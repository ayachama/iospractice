//
//  ChatScreenTests.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/20/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import XCTest

class ChatScreenTests: XCTestCase {

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

    func testSendMessage() {
        let commonActions:CommonActions = CommonActions(xcTest: self)
        
        let landingScreen: LandingScreen = LandingScreen(comActionsInstance: commonActions, appInstance: app)
        let loginScreen: LoginScreen = LoginScreen(comActionsInstance:commonActions, appInstance: app)
        let chatScreen: ChatScreen = ChatScreen(comActionsInstance:commonActions, appInstance: app)

        landingScreen.chooseToLogin()
        loginScreen.enterUserNameAndPassword()
        loginScreen.chooseLogin()
        chatScreen.isChatScreen()
        chatScreen.sendText()
        chatScreen.logout()
    }
    
}
