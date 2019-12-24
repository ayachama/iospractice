//
//  ChatScreen.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/21/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//
import Foundation
import XCTest

class ChatScreen {
    
    private let Send_Button = "Send"
    private let App_Title = "Flash Chat"
    private let Text_Entry_Default_Message = "Enter Your Message"
    private let Logout_Button = "Log Out"
    var commonActions: CommonActions
    var app: XCUIApplication

    init(comActionsInstance: CommonActions, appInstance: XCUIApplication) {
        commonActions = comActionsInstance
        app = appInstance
    }
    
    func sendText() {
        commonActions.isElementVisible(elementType: CommonActions.BUTTONS, elementId: Send_Button, elementText: Send_Button, app: app)
        commonActions.sendText(elementType: CommonActions.STATIC_TEXTS, elementId: Text_Entry_Default_Message, elementText: "Test Message", app: app)
        commonActions.tapAsync(elementType: CommonActions.BUTTONS, elementId: Send_Button, app: app)
    }
 
    func logout() {
        commonActions.isElementVisible(elementType: CommonActions.BUTTONS, elementId: Logout_Button, elementText: Logout_Button, app: app)
        commonActions.tap(elementType: CommonActions.BUTTONS, elementId: Logout_Button, app: app)
    }
    
    func isChatScreen() {
        commonActions.isElementVisibleAsync(elementType: CommonActions.BUTTONS, elementId: Logout_Button, elementText: Logout_Button, app: app)
    }

}
