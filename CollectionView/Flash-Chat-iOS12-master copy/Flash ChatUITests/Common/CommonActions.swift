//
//  CommonActions.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/20/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import XCTest

class CommonActions {
    
    var xcTestLocal: XCTestCase
    
    init(xcTest: XCTestCase) {
        xcTestLocal = xcTest
    }
    
    public static let BUTTONS = 1
    public static let STATIC_TEXTS = 2
    public static let STATIC_SECURED_TEXTS = 3
    
    func tap(elementType: Int, elementId: String, app: XCUIApplication) {
        var element: XCUIElement
        switch elementType {
        case CommonActions.BUTTONS:
            element = app.buttons[elementId]
            break
        case CommonActions.STATIC_TEXTS:
            element = app.staticTexts[elementId]
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            element = app.secureTextFields[elementId]
            break
        default:
            element = app.staticTexts[elementId]
            break
        }
        element.tap()
    }
    
    func tapAsync(elementType: Int, elementId: String, app: XCUIApplication) {
        var element: XCUIElement
        switch elementType {
        case CommonActions.BUTTONS:
            element = app.buttons[elementId]
            break
        case CommonActions.STATIC_TEXTS:
            element = app.staticTexts[elementId]
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            element = app.secureTextFields[elementId]
            break
        default:
            element = app.staticTexts[elementId]
            break
        }
        let exists1 = NSPredicate(format: "exists == 1")
        let exists2 = NSPredicate(format: "exists == true")
        xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
        xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
        xcTestLocal.waitForExpectations(timeout: 10, handler: nil)
        element.firstMatch.tap()
    }
    
    func sendText(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        var element: XCUIElement
        switch elementType {
        case CommonActions.BUTTONS:
            element = app.buttons[elementId]
            break
        case CommonActions.STATIC_TEXTS:
            element = app.textFields[elementId]
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            element = app.secureTextFields[elementId]
            break
        default:
            element = app.textFields[elementId]
            break
        }
        element.tap()
        element.typeText(elementText)
    }
    
    func sendTextAsync(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        var element: XCUIElement
        switch elementType {
        case CommonActions.BUTTONS:
            element = app.buttons[elementId]
            break
        case CommonActions.STATIC_TEXTS:
            element = app.textFields[elementId]
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            element = app.secureTextFields[elementId]
            break
        default:
            element = app.textFields[elementId]
            break
        }
        let exists1 = NSPredicate(format: "exists == 1")
        let exists2 = NSPredicate(format: "exists == true")
        xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
        xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
        xcTestLocal.waitForExpectations(timeout: 10, handler: nil)
        element.tap()
        element.typeText(elementText)
    }

    func isElementVisible(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        var element: XCUIElement
        switch elementType {
        case CommonActions.BUTTONS:
            element = app.buttons[elementId]
            break
        case CommonActions.STATIC_TEXTS:
            element = app.textFields[elementId]
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            element = app.secureTextFields[elementId]
            break
        default:
            element = app.textFields[elementId]
            break
        }
        XCTAssert(element.exists)
    }
    
    func isElementVisibleAsync(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        var element: XCUIElement
        switch elementType {
        case CommonActions.BUTTONS:
            element = app.buttons[elementId]
            break
        case CommonActions.STATIC_TEXTS:
            element = app.textFields[elementId]
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            element = app.secureTextFields[elementId]
            break
        default:
            element = app.textFields[elementId]
            break
        }
        let exists1 = NSPredicate(format: "exists == 1")
        let exists2 = NSPredicate(format: "exists == true")
        xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
        xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
        xcTestLocal.waitForExpectations(timeout: 10, handler: nil)

        XCTAssert(element.exists)
    }
    
    func scrollToFindElement() {
        
    }

}
