//
//  HipChatLinkTests.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import HipChatStringParser

class HipChatLinkTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testInitWithDictionaryWithEmptyDictionary() {
        let inputDict = [String: AnyObject]()
        
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertNotNil(link)
        XCTAssertNil(link.url)
        XCTAssertNil(link.title)
    }
    
    func testInitWithDictionaryWithNilDictionary() {
        
        let link = HCLink(dictionary: nil)
        
        XCTAssertNotNil(link)
        XCTAssertNil(link.url)
        XCTAssertNil(link.title)
    }
    
    func testInitWithDictionaryWithValidDictionary1() {
        let inputDict = [
            kHCParserDictionaryUrlKey: "https://www.google.com",
            kHCParserDictionaryTitleKey: "Google"
        ]
        
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertNotNil(link)
        XCTAssertNotNil(link.url)
        XCTAssertNotNil(link.title)
        XCTAssertTrue(link.url == NSURL(string: inputDict[kHCParserDictionaryUrlKey]!)!)
    }
    
    func testInitWithDictionryWithValidDictionary2() {
        let inputDict = [
            kHCParserDictionaryUrlKey: NSURL(string: "https://www.google.com")!,
            kHCParserDictionaryTitleKey: "Google"
        ]
        
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertNotNil(link)
        XCTAssertNotNil(link.url)
        XCTAssertNotNil(link.title)
        XCTAssertTrue(link.url == inputDict[kHCParserDictionaryUrlKey]!)
    }
    
    
    // MARK: - Test dictionary getter.
    
    func testLinkObjectToNilDictionary() {
        let link = HCLink(dictionary: nil)
        let outputDict: [NSObject: AnyObject]? = link.dictionary
        
        XCTAssertNotNil(outputDict)
        XCTAssertTrue(outputDict!.isEmpty == true)
    }
    
    func testLinkObjectToEmptyDictionary() {
        let inputDict = [String: AnyObject]()
        let link = HCLink(dictionary: inputDict)
        let outputDict: [NSObject: AnyObject]? = link.dictionary
        
        XCTAssertNotNil(outputDict)
        XCTAssertTrue(outputDict!.isEmpty == true)
    }
    
    func testLinkObjectToDictionary1() {
        let inputDict = [
            kHCParserDictionaryUrlKey: "https://www.google.com",
            kHCParserDictionaryTitleKey: "Google"
        ]
        
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: link.dictionary).isEqualToDictionary(inputDict))
    }
    
    func testLinkObjectToDictionary2() {
        let inputDict = [
            kHCParserDictionaryUrlKey: NSURL(string: "https://www.google.com")!,
            kHCParserDictionaryTitleKey: "Google"
        ]
        
        let expectedDict = [
            kHCParserDictionaryUrlKey: "https://www.google.com",
            kHCParserDictionaryTitleKey: "Google"
        ]
        
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: link.dictionary).isEqualToDictionary(expectedDict))
    }
    
    func testLinkObjectToDictionaryWithInvalidValues1() {
        let inputDict = [
            kHCParserDictionaryUrlKey: [NSURL(string: "https://www.google.com")!],
            kHCParserDictionaryTitleKey: "Google"
        ]
        let expectedDict = [
            kHCParserDictionaryTitleKey: "Google"
        ]
        let link = HCLink(dictionary: inputDict)
        let outputDict: [NSObject: AnyObject] = link.dictionary
        
        XCTAssertNil(outputDict[kHCParserDictionaryUrlKey])
        XCTAssertNotNil(outputDict[kHCParserDictionaryTitleKey])
        XCTAssertTrue(outputDict[kHCParserDictionaryTitleKey] as? String == "Google")
        XCTAssertTrue(NSDictionary(dictionary: link.dictionary).isEqualToDictionary(expectedDict))
    }

    func testLinkObjectToDictionaryWithInvalidValues2() {
        let inputDict = [
            kHCParserDictionaryUrlKey: NSURL(string: "https://www.google.com")!,
            kHCParserDictionaryTitleKey: ["Google"]
        ]
        let expectedDict = [
            kHCParserDictionaryUrlKey: "https://www.google.com"
        ]
        let link = HCLink(dictionary: inputDict)
        let outputDict: [NSObject: AnyObject] = link.dictionary
        
        XCTAssertNotNil(outputDict[kHCParserDictionaryUrlKey])
        XCTAssertNil(outputDict[kHCParserDictionaryTitleKey])
        XCTAssertTrue(outputDict[kHCParserDictionaryUrlKey] as? String == "https://www.google.com")
        XCTAssertTrue(NSDictionary(dictionary: link.dictionary).isEqualToDictionary(expectedDict))
    }
    
    
    func testLinkObjectToJsonStringWithValidDictionary1() {
        let inputDict = [
            kHCParserDictionaryUrlKey: "https://www.google.com",
            kHCParserDictionaryTitleKey: "Google"
        ]
        
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: link.dictionary).isEqualToDictionary(inputDict))
        
        let resultingJsonString = link.jsonString
        
        // Because a dictionary's order is not guaranteed, therefore it is 
        // inacurate to test that strings are equal.  Instead, cast it back to a 
        // json object and compare will be much better.
        do {
        let recastedDict = try NSJSONSerialization.JSONObjectWithData(resultingJsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments)
            
            XCTAssertTrue(NSDictionary(dictionary: recastedDict as! [NSObject : AnyObject]).isEqualToDictionary(inputDict))
        } catch _ {
            XCTFail("Test failed due to unable to cast string to json object")
        }
    }
    
    func testLinkObjectToJsonStringWithInvalidValues1() {
        let inputDict = [
            kHCParserDictionaryUrlKey: [NSURL(string: "https://www.google.com")!],
            kHCParserDictionaryTitleKey: "Google"
        ]
        let expectedDict = [
            kHCParserDictionaryTitleKey: "Google"
        ]
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: link.dictionary).isEqualToDictionary(expectedDict))
        
        let resultingJsonString = link.jsonString
        do {
            let recastedDict = try NSJSONSerialization.JSONObjectWithData(resultingJsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments)
            
            XCTAssertTrue(NSDictionary(dictionary: recastedDict as! [NSObject : AnyObject]).isEqualToDictionary(expectedDict))
        } catch _ {
            XCTFail("Test failed due to unable to cast string to json object")
        }
    }
    
    func testLinkObjectToJsonStringWithInvalidValues2() {
        let inputDict = [
            kHCParserDictionaryUrlKey: NSURL(string: "https://www.google.com")!,
            kHCParserDictionaryTitleKey: ["Google"]
        ]
        let expectedDict = [
            kHCParserDictionaryUrlKey: "https://www.google.com"
        ]
        let link = HCLink(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: link.dictionary).isEqualToDictionary(expectedDict))
        
        let resultingJsonString = link.jsonString
        do {
            let recastedDict = try NSJSONSerialization.JSONObjectWithData(resultingJsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments)
            
            XCTAssertTrue(NSDictionary(dictionary: recastedDict as! [NSObject : AnyObject]).isEqualToDictionary(expectedDict))
        } catch _ {
            XCTFail("Test failed due to unable to cast string to json object")
        }
    }

}
