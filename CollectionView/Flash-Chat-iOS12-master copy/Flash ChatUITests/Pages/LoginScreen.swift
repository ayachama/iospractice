//
//  LoginScreen.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/20/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import XCTest

class LoginScreen {
    
    private let Login_Text_Button = "Log In"
    private let Email_Field_Value = "Email"
    private let Password_Field_Value = "Password"
    var commonActions: CommonActions
    var app: XCUIApplication

    init(comActionsInstance: CommonActions, appInstance: XCUIApplication) {
        commonActions = comActionsInstance
        app = appInstance
    }
    
    func enterUserNameAndPassword() {
        // UI tests must launch the application that they test.
        commonActions.sendText(elementType: CommonActions.STATIC_TEXTS, elementId: Email_Field_Value, elementText: "sample22@a.com", app:app)
        commonActions.sendText(elementType: CommonActions.STATIC_SECURED_TEXTS, elementId: Password_Field_Value, elementText: "test@123", app:app)
    }

    func chooseLogin() {
        commonActions.tap(elementType: CommonActions.BUTTONS, elementId: Login_Text_Button, app:app)
    }
    
    func isLoginScreen(){
        
    }
}
