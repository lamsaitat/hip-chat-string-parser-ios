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
        
        parser = HCStubStringParser()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Test cases for the Atlassian requirements.
    
    func testMentionsArrayWithAtlassianInputString1() {
        let inputString = "@chris you around?"
        let expectedResults = ["chris"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        // We are only interested in comparing the elements contained, the order
        // is not a test scope.
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
}
