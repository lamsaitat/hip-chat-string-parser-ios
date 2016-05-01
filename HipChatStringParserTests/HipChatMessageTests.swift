//
//  HipChatMessageTests.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import HipChatStringParser

class HipChatMessageTests: XCTestCase {

    func testInitWithDictionaryWithEmptyDictionary() {
        let inputDict = [String: AnyObject]()
        
        let msg = HCMessage(dictionary: inputDict)
        
        XCTAssertNotNil(msg)
        XCTAssertNil(msg.chatMessage)
        XCTAssertNotNil(msg.mentions)
        XCTAssertNotNil(msg.emoticons)
        XCTAssertNotNil(msg.links)
        
        XCTAssertTrue(msg.mentions.count == 0)
        XCTAssertTrue(msg.emoticons.count == 0)
        XCTAssertTrue(msg.links.count == 0)
    }
    
    func testInitWithDictionaryWithNilDictionary() {
        let msg = HCMessage(dictionary: nil)
        
        XCTAssertNotNil(msg)
        XCTAssertNil(msg.chatMessage)
        XCTAssertNotNil(msg.mentions)
        XCTAssertNotNil(msg.emoticons)
        XCTAssertNotNil(msg.links)
        
        XCTAssertTrue(msg.mentions.count == 0)
        XCTAssertTrue(msg.emoticons.count == 0)
        XCTAssertTrue(msg.links.count == 0)
    }

    func testInitWithDictionaryWithValidDictionary1() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"]
        ]
        
        let msg = HCMessage(dictionary: inputDict)
        
        XCTAssertNotNil(msg)
        XCTAssertNil(msg.chatMessage)
        XCTAssertNotNil(msg.mentions)
        XCTAssertNotNil(msg.emoticons)
        XCTAssertNotNil(msg.links)
        
        XCTAssertTrue(msg.mentions.isEqualToArray(["ben", "tony_stark"]))
        XCTAssertTrue(msg.emoticons.count == 0)
        XCTAssertTrue(msg.links.count == 0)
    }
    
    func testInitWithDictionaryWithValidDictionary2() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryEmoticonsKey: ["megusta", "coffee"]
        ]
        
        let msg = HCMessage(dictionary: inputDict)
        
        XCTAssertNotNil(msg)
        XCTAssertNil(msg.chatMessage)
        XCTAssertNotNil(msg.mentions)
        XCTAssertNotNil(msg.emoticons)
        XCTAssertNotNil(msg.links)
        
        XCTAssertTrue(msg.mentions.isEqualToArray(["ben", "tony_stark"]))
        XCTAssertTrue(msg.emoticons.isEqualToArray(["megusta", "coffee"]))
        XCTAssertTrue(msg.links.count == 0)
    }
    
    func testInitWithDictionaryWithValidDictionary3() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryLinksKey: [
                [kHCParserDictionaryUrlKey: "https://www.google.com"]
            ]
        ]
        
        let msg = HCMessage(dictionary: inputDict)
        
        XCTAssertNotNil(msg)
        XCTAssertNil(msg.chatMessage)
        XCTAssertNotNil(msg.mentions)
        XCTAssertNotNil(msg.emoticons)
        XCTAssertNotNil(msg.links)
        
        XCTAssertTrue(msg.mentions.isEqualToArray(["ben", "tony_stark"]))
        XCTAssertTrue(msg.emoticons.count == 0)
        XCTAssertNotNil(msg.links.firstObject)
        XCTAssertTrue(msg.links.firstObject! is HCLink)
    }
    
    func testInitWithInvalidDictionary1() {
        let inputDict = [
            kHCParserDictionaryUrlKey: ["ben", "tony_stark"],
            kHCParserDictionaryMentionsKey: [
                [kHCParserDictionaryUrlKey: "https://www.google.com"]
            ]
        ]
        
        let msg = HCMessage(dictionary: inputDict)
        
        XCTAssertNotNil(msg)
        XCTAssertNil(msg.chatMessage)
        XCTAssertNotNil(msg.mentions)
        XCTAssertNotNil(msg.emoticons)
        XCTAssertNotNil(msg.links)
        
        XCTAssertTrue(msg.mentions.count == 0)
        XCTAssertTrue(msg.emoticons.count == 0)
        XCTAssertTrue(msg.links.count == 0)
    }
    
    
    // MARK: - dictionary getters
    
    func testMessageObjectToNilDictionary() {
        let message = HCMessage(dictionary: nil)
        let outputDict: [NSObject: AnyObject]? = message.dictionary
        
        XCTAssertNotNil(outputDict)
        XCTAssertTrue(outputDict!.isEmpty == true)
    }
    
    func testMessageObjectToEmptyDictionary() {
        let inputDict = [String: AnyObject]()
        let message = HCMessage(dictionary: inputDict)
        let outputDict: [NSObject: AnyObject]? = message.dictionary
        
        XCTAssertNotNil(outputDict)
        XCTAssertTrue(outputDict!.isEmpty == true)
    }
    
    func testMessageObjectToValidDictionary1() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"]
        ]
        let expectedDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"]
        ]
        let message = HCMessage(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: message.dictionary).isEqualToDictionary(expectedDict))
    }
    
    func testMessageObjectToValidDictionary2() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryEmoticonsKey: ["megusta", "coffee"]
        ]
        let expectedDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryEmoticonsKey: ["megusta", "coffee"]
        ]
        let message = HCMessage(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: message.dictionary).isEqualToDictionary(expectedDict))
    }
    
    func testMessageObjectToValidDictionary3() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryLinksKey: [
                [kHCParserDictionaryUrlKey: "https://www.google.com"]
            ]
        ]
        let expectedDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryLinksKey: [
                [kHCParserDictionaryUrlKey: "https://www.google.com"]
            ]
        ]
        let message = HCMessage(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: message.dictionary).isEqualToDictionary(expectedDict))
    }
    
    func testMessageObjectToJsonStringWithValidDictionary1() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"]
        ]
        let expectedDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"]
        ]
        let message = HCMessage(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: message.dictionary).isEqualToDictionary(expectedDict))
        
        let resultingJsonString = message.jsonString
        
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
    
    func testMessageObjectToJsonStringWithValidDictionary2() {
        let inputDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryEmoticonsKey: ["megusta", "coffee"]
        ]
        let expectedDict = [
            kHCParserDictionaryMentionsKey: ["ben", "tony_stark"],
            kHCParserDictionaryEmoticonsKey: ["megusta", "coffee"]
        ]
        let message = HCMessage(dictionary: inputDict)
        
        XCTAssertTrue(NSDictionary(dictionary: message.dictionary).isEqualToDictionary(expectedDict))
        
        let resultingJsonString = message.jsonString
        
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
    
    func testMessageObjectToJsonStringWithInvalidDictionary1() {
        let inputDict = [
            kHCParserDictionaryUrlKey: ["ben", "tony_stark"],
            kHCParserDictionaryMentionsKey: [
                [kHCParserDictionaryUrlKey: "https://www.google.com"]
            ]
        ]
        
        let message = HCMessage(dictionary: inputDict)
        
        XCTAssertTrue(message.dictionary.isEmpty)
        
        let resultingJsonString = message.jsonString
        
        // Because a dictionary's order is not guaranteed, therefore it is
        // inacurate to test that strings are equal.  Instead, cast it back to a
        // json object and compare will be much better.
        do {
            let recastedDict: [String: AnyObject] = try NSJSONSerialization.JSONObjectWithData(resultingJsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments) as! [String : AnyObject]
            
            XCTAssertTrue(recastedDict.isEmpty)
        } catch _ {
            XCTFail("Test failed due to unable to cast string to json object")
        }
    }
}
