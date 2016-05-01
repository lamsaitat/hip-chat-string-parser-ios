//
//  HipChatStringParserDictionaryTests.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest

class HipChatStringParserDictionaryTests: XCTestCase {
    var parser: HCURLFetchingStringParser?
    
    override func setUp() {
        super.setUp()
        parser = HCURLFetchingStringParser()
    }
    
    // MARK: - Error handling.
    
    func testDictionaryWithNilString() {
        let inputString: String? = nil
        let expectation = expectationWithDescription("Parse \(inputString)")
        
        let task = parser!.dictionaryFromString(
            inputString,
            completionBlock: { (dict: [NSObject : AnyObject]?, error: NSError?) in
                XCTAssertNotNil(dict)
                XCTAssertTrue(dict!.isEmpty)  // Should return empty dictionary.
                
                expectation.fulfill()
            }
        )
        
        if task != nil {
            waitForExpectationsWithTimeout(task!.originalRequest!.timeoutInterval, handler: { (error: NSError?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                task!.cancel()
            })
        } else {
            // If there is no task then timeout after 10s...  
            // It should return immediately anyway.
            waitForExpectationsWithTimeout(10, handler: { (error: NSError?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            })
        }
    }
    
    func testDictionaryWithEmptyString() {
        let inputString: String? = ""
        let expectation = expectationWithDescription("Parse \(inputString)")
        
        let task = parser!.dictionaryFromString(
            inputString,
            completionBlock: { (dict: [NSObject : AnyObject]?, error: NSError?) in
                XCTAssertNotNil(dict)
                XCTAssertTrue(dict!.isEmpty)  // Should return empty dictionary.
                
                expectation.fulfill()
            }
        )
        
        if task != nil {
            waitForExpectationsWithTimeout(task!.originalRequest!.timeoutInterval, handler: { (error: NSError?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                task!.cancel()
            })
        } else {
            // If there is no task then timeout after 10s...
            // It should return immediately anyway.
            waitForExpectationsWithTimeout(10, handler: { (error: NSError?) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            })
        }
    }
}
