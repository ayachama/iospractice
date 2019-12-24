//
//  LandingScreen.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/20/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import XCTest

class LandingScreen {
    
    let Login_Text_Button = "Log In"
    var commonActions: CommonActions
    var app: XCUIApplication
    
    init(comActionsInstance: CommonActions, appInstance: XCUIApplication) {
        commonActions = comActionsInstance
        app = appInstance
    }
    
    func chooseToLogin() {
        commonActions.tap(elementType: CommonActions.BUTTONS, elementId: Login_Text_Button, app: app)
    }

    func isLandingScreen(){
        
    }

}
