//
//  VC1Test.swift
//  MoodieTests
//
//  Created by Griffin on 5/13/18.
//  Copyright © 2018 Griffin. All rights reserved.
//

import XCTest

class VC1Test: XCTestCase {
    var VC1: UIViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "main", bundle: nil)
        VC1 = storyboard.instantiateInitialViewController()!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        VC1 = nil
        super.tearDown()
    }
    
    func testNewUser() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
