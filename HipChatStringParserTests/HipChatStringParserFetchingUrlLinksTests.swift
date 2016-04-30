//
//  HipChatStringParserFetchingUrlLinksTests.swift
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

import XCTest
@testable import HipChatStringParser

// Note: We assume that to fetch for page title of a URL, there must be internet
// connection.  The Reachability check is probably best handled by view controllers
// as it can display alerts and indicators based on the Reachability status.
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
    
    func testPageTitleFetchingWithLongerPageTitle() {
        let inputString = "http://nshipster.com/xctestcase/"
        let url = NSURL(string: inputString)
        let expectedResult = "XCTestCase / XCTestExpectation /  measureBlock() - NSHipster"
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
    
    
    // MARK: - Test for Atlassian test cases
    
    func testPageTitleFetchingWithAtlassianTestCase3() {
        let inputString = "http://www.nbcolympics.com/"
        let url = NSURL(string: inputString)
        let expectedResult = "2016 Rio Olympic Games | NBC Olympics"
        let atlassianProvidedExpectedResult = "NBC Olympics | 2014 NBC Olympics in Sochi Russia"
        let expectation = expectationWithDescription("GET \(url)")
        
        let task = parser!.pageTitleForURL(
            url,
            completionBlock: { (pageTitle: String?, error: NSError?) in
                
                XCTAssertTrue(error == nil && pageTitle != nil && pageTitle! == expectedResult)
                // As of 2016-05-01 the page has updated it's title from 2014 Sochi Winter Olympics
                // to 2016 Rio Olympics
                XCTAssertTrue(error == nil && pageTitle != nil && pageTitle! != atlassianProvidedExpectedResult)
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
    
    func testPageTitleFetchingWithAtlassianTestCase4() {
        let inputString = "https://twitter.com/jdorfman/status/430511497475670016"
        let url = NSURL(string: inputString)
        let expectedResult = "Justin Dorfman on Twitter: \"nice @littlebigdetail from @HipChat (shows hex colors when pasted in chat). http://t.co/7cI6Gjy5pq\""
        let atlassianProvidedExpectedResult = "Twitter / jdorfman: nice @littlebigdetail from ..."
        let expectation = expectationWithDescription("GET \(url)")
        
        let task = parser!.pageTitleForURL(
            url,
            completionBlock: { (pageTitle: String?, error: NSError?) in
                
                XCTAssertTrue(error == nil && pageTitle != nil && pageTitle! == expectedResult)
                // As of 2016-05-01
                // The page title provided in the specs is truncated, and actually 
                // Twitter has changed the page title, that is actually incorrect 
                // from the result's POV.
                XCTAssertTrue(error == nil && pageTitle != nil && pageTitle! != atlassianProvidedExpectedResult)
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
