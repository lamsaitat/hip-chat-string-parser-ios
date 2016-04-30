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
        
        parser = HCParserFactory.parser()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // MARK: - Error handling test cases.
    
    func testMentionsArrayWithNilString() {
        let inputString: String? = nil
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        // We are only interested in comparing the elements contained, the order
        // is not a test scope.
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithEmptyInputString() {
        let inputString = ""
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Testing valid mentions
    
    
    func testMentionsArrayWithSimpleValidString1() {
        let inputString = "@bruceWyane is Batman."
        let expectedResults = ["bruceWyane"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithValidString2ContainsUnderscore() {
        let inputString = "@Clark_Kent has a collection of Superman suits."
        let expectedResults = ["Clark_Kent"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithMultipleMentions1() {
        let inputString = "@Clark_Kent has a collection of @Superman suits. - @Batman"
        let expectedResults = ["Clark_Kent", "Superman", "Batman"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    
    // MARK: - Edge cases
    
    func testMentionsArrayWithReallyLongMention1() {
        let inputString = "@DaenerysOfHouseTargaryen_theFirstOfHerName_QueenOfMeereen_QueenOfTheAndals_theRhoynarAndTheFirstMen_LadyRegnantOfTheSevenKingdoms_ProtectorOfTheRealm_KhaleesiOfTheGreatGrassSea_BreakerOfChains_MotherOfDragons hey your name is way too long. - @Jorah"
        let expectedResults = ["DaenerysOfHouseTargaryen_theFirstOfHerName_QueenOfMeereen_QueenOfTheAndals_theRhoynarAndTheFirstMen_LadyRegnantOfTheSevenKingdoms_ProtectorOfTheRealm_KhaleesiOfTheGreatGrassSea_BreakerOfChains_MotherOfDragons", "Jorah"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
        XCTAssertFalse(
            Set(parsedResults).contains(
                "DaenerysOfHouseTargaryen_theFirstOfHerName_QueenOfMeereen_QueenOfTheAndals_theRhoynar"
            )
        )
    }
    
    func testMentionsArrayWithPunctuationsAndSomeUserError() {
        let inputString = "@rhody_iron_patriot, @blackPanther_is_so_badass, vision you guys storm the front and take care of Steve, @yourFriendlyNeighborSpiderman when I signal, get rid of his shield. - @tony_ironman_stark"
        let expectedResults = ["rhody_iron_patriot", "blackPanther_is_so_badass", "yourFriendlyNeighborSpiderman", "tony_ironman_stark"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
        XCTAssertFalse(Set(parsedResults).contains("vision"))
        XCTAssertFalse(Set(parsedResults).contains("rhody_iron_patriot,"))
        XCTAssertFalse(Set(parsedResults).contains(" @blackPanther_is_so_badass"))
    }
    
    func testMentionsArrayWithEmailAsMentionName() {
        // The spec defines a mention as "Always starts with an '@' and ends when 
        // hitting a non-word character".  A mention is typically a username,
        // which in some services email is a valid username, so for those services
        // the valid result should be "jimmyk@atlassian.com", however based on the
        // specs, the '@' after "jimmyk" is a non word character, therefore 
        // "jimmyk" is a valid mention, and the pointer technically stops just 
        // before the 2nd '@', therefore the next chunk is @atlassian since '.' 
        // is a non word character.
        let inputString = "For all other inquiries, please contact @jimmyk@atlassian.com"
        let expectedResults = ["jimmyk", "atlassian"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
        XCTAssertFalse(Set(parsedResults).contains("jimmyk@atlassian.com"))
        XCTAssertFalse(Set(parsedResults).contains("atlassian.com"))
    }
    
    
    // MARK: - Test cases for the Atlassian requirements.
    
    func testMentionsArrayWithAtlassianInputString1() {
        let inputString = "@chris you around?"
        let expectedResults = ["chris"]
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithAtlassianInputString2() {
        let inputString = "Good morning! (megusta) (coffee)"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithAtlassianInputString3() {
        let inputString = "Olympics are starting soon;http://www.nbcolympics.com"
        let expectedResults = [String]() // Empty array.
        let parsedResults = parser!.mentionsFromString(inputString)
        
        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
    
    func testMentionsArrayWithAtlassianInputString4() {
        let inputString = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
        let expectedResults = ["bob", "john"]
        let parsedResults = parser!.mentionsFromString(inputString)

        XCTAssertTrue(Set(parsedResults).elementsEqual(Set(expectedResults)))
    }
}
