//
//  Flash_ChatUITests.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/20/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {

    private let Login_Text_Button = "Log In"
    private let Email_Field_Value = "Email"
    private let Password_Field_Value = "Password"
        
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

       
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 12.4, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }

    func testLoginFlow() {
        // UI tests must launch the application that they test.
        let commonActions:CommonActions = CommonActions(xcTest: self)

        let landingScreen: LandingScreen = LandingScreen(comActionsInstance: commonActions, appInstance: app)
        let loginScreen: LoginScreen = LoginScreen(comActionsInstance:commonActions, appInstance: app)

        landingScreen.chooseToLogin()
        loginScreen.enterUserNameAndPassword()
    }
    
    func testSignUpFlow() {
        // UI tests must launch the application that they test.
        let commonActions:CommonActions = CommonActions(xcTest: self)
        // To be implemented.
    }
    
}
