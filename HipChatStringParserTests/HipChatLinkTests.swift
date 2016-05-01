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

}
