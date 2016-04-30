//
//  HipChatStringParserTests.swift
//  HipChatStringParserTests
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import HipChatStringParser

class HipChatStringParserTests: XCTestCase {
    var parser: HCParser?
    
    override func setUp() {
        super.setUp()
        
        parser = HCParserFactory.parser()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Error handling test cases.
    
    func testMentionsArrayWithNilString() {
        let inputString: String? = nil
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        // We are only interested in comparing the elements contained, the order
        // is not a test scope.
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithEmptyInputString() {
        let inputString = ""
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Testing valid mentions
    
    
    func testMentionsArrayWithSimpleValidString1() {
        let inputString = "@bruceWyane is Batman."
        let expectedResults = ["bruceWyane"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithValidString2ContainsUnderscore() {
        let inputString = "@Clark_Kent has a collection of Superman suits."
        let expectedResults = ["Clark_Kent"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithMultipleMentions1() {
        let inputString = "@Clark_Kent has a collection of @Superman suits. - @Batman"
        let expectedResults = ["Clark_Kent", "Superman", "Batman"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Test cases for the Atlassian requirements.
    
    func testMentionsArrayWithAtlassianInputString1() {
        let inputString = "@chris you around?"
        let expectedResults = ["chris"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithAtlassianInputString2() {
        let inputString = "Good morning! (megusta) (coffee)"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithAtlassianInputString3() {
        let inputString = "Olympics are starting soon;http://www.nbcolympics.com"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithAtlassianInputString4() {
        let inputString = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
        let expectedResults = ["bob", "john"]
        let parsedResults = parser!.mentionsFromString(inputString)

        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
}
