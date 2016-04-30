//
//  HipChatStringParserFetchingUrlLinksTests.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import HipChatStringParser

class HipChatStringParserFetchingUrlLinksTests: XCTestCase {
    var parser: HCURLFetchingStringParser?
    
    override func setUp() {
        super.setUp()
        parser = HCURLFetchingStringParser()
    }
    
    // MARK: - Test for valid urls
    
    func testPageTitleFetchingWithSimpleUrl1() {
        let inputString = "https://www.google.com.au"
        let url = NSURL(string: inputString)
        let expectedResult = "Google"
        let expectation = expectationWithDescription("GET \(url)")
        
        let task = parser!.pageTitleForURL(
            url,
            completionBlock: { (pageTitle: String?, error: NSError?) in
                
                XCTAssertTrue(error == nil && pageTitle != nil && pageTitle! == expectedResult)
                expectation.fulfill()
            }
        )
        
        waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
}
