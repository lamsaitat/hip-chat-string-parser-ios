//
//  HipChatStringParserUrlLinksTests.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import HipChatStringParser

class HipChatStringParserUrlLinksTests: XCTestCase {
    var parser: HCParser?
    
    override func setUp() {
        super.setUp()
        
        parser = HCParserFactory.parser()
    }
    
    // MARK: - Error handling test cases.
    
    func testUrlLinksArrayWithNilString() {
        let inputString: String? = nil
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.urlLinksFromString(inputString)
        // We are only interested in comparing the elements contained, the order
        // is not a test scope.
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testUrlLinksArrayWithEmptyInputString() {
        let inputString = ""
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testUrlLinksWithIncomplete() {
        let inputString = "https://"
        
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Valid results
    
    func testUrlLinksArrayWithSimpleUrl1() {
        let inputString = "http://www.google.com"
        let expectedResults = ["http://www.google.com"]
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testUrlLinksArrayWithComplexUrlAndQueryString() {
        let inputString = "http://www.carsales.com.au/cars/results?area=Stock&vertical=car&sortBy=TopDeal&q=%28%28%28Make%3D%5BHonda%5D%29%26%28Model%3D%5BNSX%5D%29%29%26%28Service%3D%5BCarsales%5D%29%29&WT.z_srchsrcx=makemodel"
        let expectedResults = ["http://www.carsales.com.au/cars/results?area=Stock&vertical=car&sortBy=TopDeal&q=%28%28%28Make%3D%5BHonda%5D%29%26%28Model%3D%5BNSX%5D%29%29%26%28Service%3D%5BCarsales%5D%29%29&WT.z_srchsrcx=makemodel"]
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Test cases for the Atlassian requirements.
    
    func testUrlLinksArrayWithAtlassianInputString1() {
        let inputString = "@chris you around?"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testUrlLinksArrayWithAtlassianInputString2() {
        let inputString = "Good morning! (megusta) (coffee)"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testUrlLinksArrayWithAtlassianInputString3() {
        let inputString = "Olympics are starting soon;http://www.nbcolympics.com"
        let expectedResults = ["http://www.nbcolympics.com"]
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testUrlLinksArrayWithAtlassianInputString4() {
        let inputString = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
        let expectedResults = ["https://twitter.com/jdorfman/status/430511497475670016"]
        let parsedResults = parser!.urlLinksFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
}
