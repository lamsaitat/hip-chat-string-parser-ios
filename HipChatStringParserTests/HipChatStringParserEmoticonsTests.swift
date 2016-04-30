//
//  HipChatStringParserEmoticonsTests.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import HipChatStringParser

class HipChatStringParserEmoticonsTests: XCTestCase {
    
    var parser: HCParser?
    
    override func setUp() {
        super.setUp()
        
        parser = HCParserFactory.parser()
    }
    

    // MARK: - Error handling test cases.
    
    func testEmoticonsArrayWithNilString() {
        let inputString: String? = nil
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.emoticonsFromString(inputString)
        // We are only interested in comparing the elements contained, the order
        // is not a test scope.
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithEmptyInputString() {
        let inputString = ""
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Valid results
    
    func testEmoticonsArrayWithSimpleInputString1() {
        let inputString = "(jonsnow) is still dead."
        let expectedResults = ["jonsnow"]
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithSimpleInputString2() {
        let inputString = "(daenerys) will not rule the seven kingdoms."
        let expectedResults = ["daenerys"]
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithMultipleValidResults() {
        let inputString = "(daenerys) (jonsnow) (arya) have featured in the episode 1 of Game of Thrones."
        let expectedResults = ["daenerys", "jonsnow", "arya"]
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Edge cases
    
    func testEmoticonsArrayWithDuplicateValidEmoticons() {
        let inputString = "(hodor) (hodor), (hodor)(hodor)(hodor)"
        let expectedResults = ["hodor"]
        
        let parsedResults = parser!.uniqueEmoticonsFromString(inputString)

        if let parsedResultsArray = parsedResults.array as? [String] where parsedResults != nil {
            XCTAssertTrue(parsedResultsArray.elementsEqual(expectedResults))
            XCTAssertFalse(parsedResultsArray.elementsEqual(["hodor", "hodor", "hodor", "hodor", "hodor"]))
        } else {
            XCTAssert(false, "Test failed due to results failed to be casted as array of string")
        }
    }
    
    func testEmoticonsArrayWithEmoticonStringTooLong() {
        let inputString = "(iseewhatyoudidthere)"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithMultipleNonAlphanumbericCharacters() {
        let inputString = "((laskdfj*&^)"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithTheFullSet() {
        // Test string text file extracted from https://www.hipchat.com/emoticons
        // There are 2 emoticons from the list that is too long to fit within specs.
        
        let testFilePath = NSBundle(forClass: self.dynamicType).pathForResource("emoticons-list-newlined", ofType: "txt")
        if testFilePath != nil {
            do {
                let inputString = try String(contentsOfFile: testFilePath!, encoding: NSUTF8StringEncoding)
                let expectedResultsCount = 208
                let parsedResults = parser!.emoticonsFromString(inputString)
                XCTAssertTrue(parsedResults.count == expectedResultsCount)
                XCTAssertFalse(parsedResults.count == 210)
            } catch _ {
                XCTAssert(false, "Test failed due to failing to read the test file into string object")
            }
        } else {
            XCTAssert(false, "Test failed due to failing to locate the test file")
        }
    }
    
    
    // MARK: - Test cases for the Atlassian requirements.
    
    func testEmoticonsArrayWithAtlassianInputString1() {
        let inputString = "@chris you around?"
        let expectedResults = [String]() // Empty array
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithAtlassianInputString2() {
        let inputString = "Good morning! (megusta) (coffee)"
        let expectedResults = ["megusta", "coffee"]
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithAtlassianInputString3() {
        let inputString = "Olympics are starting soon;http://www.nbcolympics.com"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testEmoticonsArrayWithAtlassianInputString4() {
        let inputString = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
        let expectedResults = ["success"]
        let parsedResults = parser!.emoticonsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
}
