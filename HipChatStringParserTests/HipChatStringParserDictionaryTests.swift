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
    
    
    // MARK: - Base dictionary test cases.
    
    // MARK: Error handling.
    
    func testDictionaryWithNilString() {
        let inputString: String? = nil
        
        let parserResults = parser!.dictionaryFromString(inputString)
        
        XCTAssertTrue(parserResults.isEmpty)
    }
    
    func testDictionaryWithEmptyString() {
        let inputString: String? = ""
        
        let parserResults = parser!.dictionaryFromString(inputString)
        
        XCTAssertTrue(parserResults.isEmpty)
    }
    
    
    // MARK: - Test for valid input
    
    func testDictionaryWithSimpleStringMentionOnly1() {
        let inputString = "@bruceWyane is Batman."
        let expectedDict = [kHCParserDictionaryMentionsKey: ["bruceWyane"]]
        let parserResults = parser!.dictionaryFromString(inputString)
        
        // The best way to compare the results is to turn them into JSON data
        // with consistent JSON write options.
        do {
            let expectedJsonData = try NSJSONSerialization.dataWithJSONObject(expectedDict, options: .PrettyPrinted)
            let resultsJsonData = try NSJSONSerialization.dataWithJSONObject(parserResults, options: .PrettyPrinted)
            
            // Because NSData is objective-c class, therefore I prefer to use 
            // the good old isEqual method to compare data as specified in the 
            // Apple doc:
            // Two data objects are equal if they hold the same number of bytes, and if the bytes at the same position in the objects are the same.
            // https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSData_Class/#//apple_ref/occ/instm/NSData/isEqualToData:
            XCTAssertTrue(expectedJsonData.isEqualToData(resultsJsonData))
        } catch _ {
            XCTFail("Test case failed due to failing to serialise either the expectedDict or results into json data.")
        }
    }
    
    func testDictinoaryWithSimpleStringEmoticonsOnly1() {
        let inputString = "(jonsnow) is still dead."
        let expectedDict = [kHCParserDictionaryEmoticonsKey: ["jonsnow"]]
        let parserResults = parser!.dictionaryFromString(inputString)
        
        XCTAssertTrue(NSDictionary(dictionary: parserResults).isEqualToDictionary(NSDictionary(dictionary: expectedDict) as [NSObject : AnyObject]))
    }
    
    func testDictinoaryWithCombinedStringOfMentionsAndEmoticons1() {
        let inputString = "@jonsnow looks like this (jonsnow). He knows nothing."
        let expectedDict = [
            kHCParserDictionaryMentionsKey: ["jonsnow"],
            kHCParserDictionaryEmoticonsKey: ["jonsnow"]
        ]
        let parserResults = parser!.dictionaryFromString(inputString)
        
        // Turns out comparing the json object byte is not an accurate comparison
        // as Dictionary's key order can be different and the json string will 
        // therefore not be the same.
        // After some research the simplest way to compare dictionaries is to 
        // cast them back to NSDictionary objects as <NSCoding, NSObject>, 
        // the isEqualToDictionary: can then compare the key-value pair without
        // considerations of the key's order.
        // Ref: http://stackoverflow.com/a/32366918
        XCTAssertTrue(NSDictionary(dictionary: parserResults).isEqualToDictionary(NSDictionary(dictionary: expectedDict) as [NSObject : AnyObject]))
    }
    
    
    // MARK: - Asynchronously fetching the url and return the dictionary only if the page title fetching request returns.
    
    // MARK: - Error handling.
    
    func testAsyncDictionaryWithNilString() {
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
    
    func testAsyncDictionaryWithEmptyString() {
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
