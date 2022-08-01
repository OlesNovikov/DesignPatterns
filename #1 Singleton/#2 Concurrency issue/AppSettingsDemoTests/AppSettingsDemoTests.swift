//
//  AppSettingsDemoTests.swift
//  AppSettingsDemoTests
//
//  Created by Karoly Nyisztor on 2/11/19.
//  Copyright © 2019 Karoly Nyisztor. All rights reserved.
//

import XCTest
@testable import AppSettingsDemo

class AppSettingsDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConcurrentUsage() {
        let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
        let expect = expectation(description: "Using AppSettings.shared from multiple threads shall succeed")
        
        let callCount = 100
        for callIndex in 1...callCount {
            concurrentQueue.async {
                AppSettings.shared.set(value: callIndex, forKey: String(callIndex))
            }
        }
        
        while AppSettings.shared.int(forKey: String(callCount)) != callCount {
            // nop
        }
        
        expect.fulfill()
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Test expectation failed")
        }
    }

}
