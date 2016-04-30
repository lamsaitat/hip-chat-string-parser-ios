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
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
}
