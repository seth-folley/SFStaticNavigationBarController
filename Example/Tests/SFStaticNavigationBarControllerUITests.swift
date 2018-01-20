//
//  SFStaticNavigationBarControllerUITests.swift
//  SFStaticNavigationBarController_Tests
//
//  Created by Seth Folley on 1/20/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import UIKit

class SFStaticNavigationBarControllerUITests: XCTestCase {
    var application: XCUIApplication!

    override func setUp() {
        super.setUp()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        application = XCUIApplication()
        application.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testUI() {
        XCTAssert(true)
    }
}
