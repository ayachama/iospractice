//
//  CommonActions.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/20/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import XCTest
/**
 Common actions to be used across all the screens and tests classes.
 */
public class CommonActions {
    
    var xcTestCase: XCTestCase
    var app: XCUIApplication
    
    init(xcTest: XCTestCase, app: XCUIApplication) {
        self.xcTestCase = xcTest
        self.app = app
    }
    
    public static let BUTTONS = 1
    public static let STATIC_TEXTS = 2
    public static let STATIC_SECURED_TEXTS = 3
    public static let COLLECTION_VIEW = 4
    public static let TABLE_VIEW = 5
    public static let LABLE_VIEW = 6
    public static let TABLE_CELL = 7
    public static let UI_VIEW = 8
    public static let TEXT_FIELD = 9
    public static let CHECK_BOX = 10
    public static let CELLS = 11
    public static let TEXT_VIEW = 12
    public static let NAVIGATION_BAR = 13
    public enum Swipe {
        case up
        case down
    }
    
    // Performs tap operation on certaion element with ID.
    public func tap(elementType: Int, elementId: String, app: XCUIApplication) {
        if let element: XCUIElement = fetchElement(elementType: elementType, elementId: elementId) {
            element.tap()
        }
    }
    
    // Waits for element to be visible on the screen, will throw an exception is element hasn't loaded in given wait time.
    public func waitForElementAsync(elementType: Int, elementId: String, app: XCUIApplication) -> XCUIElement? {
        return waitForElementAsync(elementType: elementType, elementId: elementId, app: app, timeout: 10.0)
    }
    
    // Waits for element to be visible on the screen, will throw an exception is element hasn't loaded in given wait time.
    public func waitForElementAsync(elementType: Int, elementId: String, app: XCUIApplication, timeout: Double) -> XCUIElement? {
        var xcElement: XCUIElement?
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            XCTWaiter.wait(for: [expect1, expect2], timeout: timeout)
            xcElement = element
        }
        return xcElement
    }
    
    // Waits for element to be visible on the screen, will swallow the exception if element hasn't loaded in given timeout.
    public func waitSafeForElementAsync(elementType: Int, elementId: String, app: XCUIApplication, timelimit: Double) -> Bool? {
        var isFound: Bool = true
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: timelimit)
            if result == .timedOut {
                isFound = false
            }
        }
        return isFound
    }
    
    // Waits for element to be visible on the screen, will swallow the exception if element hasn't loaded in given wait time 10 seconds.
    public func waitSafeForElementAsync(elementType: Int, elementId: String, app: XCUIApplication) -> Bool? {
        return waitSafeForElementAsync(elementType: elementType, elementId: elementId, app: app, timelimit: 10.0)
    }
    
    // Drags the element from it's current location to coordinates of toElement.
    public func dragElementUp(elementType: Int, elementId: String, app: XCUIApplication, toElement: XCUIElement) {
        if let element: XCUIElement = fetchElement(elementType: elementType, elementId: elementId) {
            self.app = app
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 10)
            if result != .timedOut {
                if element.isHittable {
                    element.press(forDuration: 1, thenDragTo: toElement)
                } else {
                    let startcoordinate: XCUICoordinate = element.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
                    let finishcoordinate: XCUICoordinate = toElement.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
                    startcoordinate.press(forDuration: 1, thenDragTo: finishcoordinate)
                }
            }
        }
    }
    
    // Drags the element from it's current location to + .
    public func dragElementUp(elementType: Int, elementId: String, app: XCUIApplication) {
        if let element: XCUIElement = fetchElement(elementType: elementType, elementId: elementId) {
            self.app = app
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 10)
            if result != .timedOut {
                let start = element.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
                let finish = element.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: -15))
                start.press(forDuration: 1, thenDragTo: finish)
            }
        }
    }
    
    // Performs tap operation on certaion element with ID and waits for element to appear.
    public func tapAsync(elementType: Int, elementId: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 30)
            if result != .timedOut {
                element.firstMatch.tap()
            } else {
                XCTFail(">>>>> Element not found in timeout to perform Tap \(elementId)")
            }
        } else {
            XCTFail(">>>>> Element not found to perform Tap \(elementId)")
        }
    }
    
    // Performs tap operation on certaion element with ID and waits for element to appear.
    // If element doesn't appear no error is thrown, execution is continued.
    public func tapAsyncSafe(elementType: Int, elementId: String, app: XCUIApplication, timeOut: Double) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: timeOut)
            if result != .timedOut {
                element.firstMatch.tap()
            }
        }
    }
    
    // Sends text for a particular element with id.
    public func sendText(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element = getXCElement(elementType: elementType, elementId: elementId) {
            element.doubleTap()
            xcTestCase.tapElementAndWaitForKeyboardToAppear(element: element)
            element.typeText(elementText)
        }
    }
    
    // Sends text for a particular element with id and waits for element to appear.
    public func sendTextAsync(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 5.0)
            if result != .timedOut {
                element.doubleTap()
                element.typeText(elementText)
            }
        }
    }
    
    // Sends text for a particular element with id.
    public func clearAndSendText(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element = getXCElement(elementType: elementType, elementId: elementId) {
            element.clearAndEnterText(text: elementText)
        }
    }
    
    // Checks if particular element with id is visisble.
    public func isElementVisible(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            XCTAssert(element.exists)
        }
    }
    
    // Checks if particular element with id is visisble and waits for element to appear.
    public func isElementVisibleAsync(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            var isFound : Bool = true
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestCase.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestCase.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 10)
            if result == .timedOut {
                isFound = false
            }
            XCTAssert(isFound)
        }
    }
    
    public func isElementFound(elementType: Int, elementId: String) -> Bool {
        guard let _: XCUIElement = fetchElement(elementType: elementType, elementId: elementId) else {
            return false
        }
        return true
    }
    
    func scrollCollectionToFind(cellIdentifier: String, collectionViewElementId: String, scrollUp: Bool = false, fullyVisible: Bool = false) -> Bool {
        var rtn = false
        var lastMidCellID = ""
        var lastMidCellRect = CGRect.zero
        
        if let collectionViewElement = fetchElement(elementType: CommonActions.COLLECTION_VIEW, elementId: collectionViewElementId) {
            var currentMidCell = collectionViewElement.cells.element(boundBy: collectionViewElement.cells.count / 3)
            
            // Scroll until the requested cell is hittable, or until we try and scroll but nothing changes
            while (lastMidCellID != currentMidCell.identifier || !lastMidCellRect.equalTo(currentMidCell.frame)) {
                if (collectionViewElement.cells.matching(identifier: cellIdentifier).count > 0 && collectionViewElement.cells[cellIdentifier].exists && collectionViewElement.cells[cellIdentifier].isHittable) {
                    rtn = true
                    break;
                }
                lastMidCellID = currentMidCell.identifier
                lastMidCellRect = currentMidCell.frame      // Need to capture this before the scroll
                
                if (scrollUp) {
                    collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.4)).press(forDuration: 0.5, thenDragTo: collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.9)))
                }
                else {
                    collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.9)).press(forDuration: 0.5, thenDragTo: collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.4)))
                }
                if collectionViewElement.cells.element.waitForExistence(timeout: 3) == false {
                    break
                }
                currentMidCell = collectionViewElement.cells.element(boundBy: collectionViewElement.cells.count / 3)
            }
            
            // If we want cell fully visible, do finer scrolling (1/2 height of cell relative to collection view) until cell frame fully contained by collection view frame
            if (fullyVisible) {
                let cell = collectionViewElement.cells[cellIdentifier]
                let scrollDistance = (cell.frame.height / 2) / collectionViewElement.frame.height
                
                while (!collectionViewElement.frame.contains(cell.frame)) {
                    if (cell.frame.minY < collectionViewElement.frame.minY) {
                        collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.5)).press(forDuration: 0.5, thenDragTo: collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.5 + scrollDistance)))
                    }
                    else {
                        collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.5)).press(forDuration: 0.5, thenDragTo: collectionViewElement.coordinate(withNormalizedOffset: CGVector(dx: 0.99, dy: 0.5 - scrollDistance)))
                    }
                    if collectionViewElement.waitForExistence(timeout: 3) == false {
                        break
                    }
                }
            }
        }
        return rtn;
    }
    
    func scrollToElement(elementType: Int, elementId: String, direction: Swipe) -> XCUIElement?
    {
        var limit: Int = 0
        waitSafeForElementAsync(elementType: elementType, elementId: elementId, app: app, timelimit: 2.0)
        guard let element = getXCElement(elementType: elementType, elementId: elementId) else {
            return nil
        }
        while !element.visible() && limit < 3
        {
            var startCoord: XCUICoordinate
            var endCoord: XCUICoordinate
            if direction == Swipe.down {
                startCoord = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
                endCoord = startCoord.withOffset(CGVector(dx: 0.5, dy: -262));
                startCoord.press(forDuration: 0.1, thenDragTo: endCoord)
            } else if direction == Swipe.up {
                startCoord = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: -262))
                endCoord = startCoord.withOffset(CGVector(dx: 0.5, dy: 0.5));
                startCoord.press(forDuration: 0.1, thenDragTo: endCoord)
            }
            limit = limit + 1
        }
        return element
    }
    
    public func getXCElement(elementType: Int, elementId: String) -> XCUIElement? {
        var element: XCUIElement
        switch elementType {
        case CommonActions.BUTTONS:
            //            element = app.buttons.element(matching: .button, identifier: elementId)
            element = app.buttons[elementId]
            break
        case CommonActions.STATIC_TEXTS:
            element = app.staticTexts.element(matching: .staticText, identifier: elementId)
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            element = app.secureTextFields[elementId]
            break
        case CommonActions.COLLECTION_VIEW:
            element = app.collectionViews[elementId]
            break
        case CommonActions.TABLE_VIEW:
            element = app.tables[elementId]
            break
        case CommonActions.TABLE_CELL:
            element = app.tables.cells[elementId]
            break
        case CommonActions.LABLE_VIEW:
            element = app.staticTexts[elementId]
            break
        case CommonActions.CELLS:
            element = app.cells[elementId]
            break
        case CommonActions.UI_VIEW:
            element = app.otherElements[elementId]
            break
        case CommonActions.TEXT_FIELD:
            //            element = app.textFields.element(matching: .textField, identifier: elementId)
            element = app.textFields[elementId]
            break
        case CommonActions.TEXT_VIEW:
            //            element = app.textFields.element(matching: .textField, identifier: elementId)
            element = app.textViews[elementId]
            break
        case CommonActions.CHECK_BOX:
            element = app.checkBoxes[elementId]
            break
        case CommonActions.NAVIGATION_BAR:
            element = app.navigationBars[elementId]
            break
        default:
            element = app.staticTexts[elementId]
            break
        }
        return element
    }
    
    public func fetchElement(elementType: Int, elementId: String) -> XCUIElement? {
        var elementQuery: XCUIElementQuery
        var element: XCUIElement?
        switch elementType {
        case CommonActions.BUTTONS:
            elementQuery = app.buttons.matching(identifier: elementId)
            break
        case CommonActions.STATIC_TEXTS:
            elementQuery = app.staticTexts.matching(identifier: elementId)
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            elementQuery = app.secureTextFields.matching(identifier: elementId)
            break
        case CommonActions.COLLECTION_VIEW:
            elementQuery = app.collectionViews.matching(identifier: elementId)
            break
        case CommonActions.TABLE_VIEW:
            elementQuery = app.tables.matching(identifier: elementId)
            break
        case CommonActions.CELLS:
            elementQuery = app.cells.matching(identifier: elementId)
            break
        case CommonActions.TABLE_CELL:
            elementQuery = app.tables.cells.matching(identifier: elementId)
            break
        case CommonActions.LABLE_VIEW:
            elementQuery = app.staticTexts.matching(.any, identifier: elementId)
            break
        case CommonActions.UI_VIEW:
            elementQuery = app.otherElements.matching(identifier: elementId)
            break
        case CommonActions.TEXT_FIELD:
            elementQuery = app.textFields.matching(identifier: elementId)
            break
        case CommonActions.TEXT_VIEW:
            elementQuery = app.textViews.matching(identifier: elementId)
            break
        case CommonActions.CHECK_BOX:
            elementQuery = app.checkBoxes.matching(identifier: elementId)
            break
        case CommonActions.NAVIGATION_BAR:
            elementQuery = app.navigationBars.matching(identifier: elementId)
            break
        default:
            elementQuery = app.staticTexts.matching(identifier: elementId)
            break
        }
        if elementQuery.count > 0 {
            element = elementQuery.element(boundBy: 0)
            return element
        }
        return nil
    }
    
    public func getAllElementsByElementId(elementType: Int, elementId: String) -> XCUIElementQuery? {
        var elementQuery: XCUIElementQuery? = nil
        switch elementType {
        case CommonActions.BUTTONS:
            elementQuery = app.buttons.matching(identifier: elementId)
            break
        case CommonActions.STATIC_TEXTS:
            elementQuery = app.staticTexts.matching(identifier: elementId)
            break
        case CommonActions.STATIC_SECURED_TEXTS:
            elementQuery = app.secureTextFields.matching(identifier: elementId)
            break
        case CommonActions.COLLECTION_VIEW:
            elementQuery = app.collectionViews.matching(identifier: elementId)
            break
        case CommonActions.TABLE_VIEW:
            elementQuery = app.tables.matching(identifier: elementId)
            break
        case CommonActions.CELLS:
            elementQuery = app.cells.matching(identifier: elementId)
            break
        case CommonActions.TABLE_CELL:
            elementQuery = app.tables.cells.matching(identifier: elementId)
            break
        case CommonActions.LABLE_VIEW:
            elementQuery = app.staticTexts.matching(.any, identifier: elementId)
            break
        case CommonActions.UI_VIEW:
            elementQuery = app.otherElements.matching(identifier: elementId)
            break
        case CommonActions.TEXT_FIELD:
            elementQuery = app.textFields.matching(identifier: elementId)
            break
        case CommonActions.TEXT_VIEW:
            elementQuery = app.textViews.matching(identifier: elementId)
            break
        case CommonActions.CHECK_BOX:
            elementQuery = app.checkBoxes.matching(identifier: elementId)
            break
        case CommonActions.NAVIGATION_BAR:
            elementQuery = app.navigationBars.matching(identifier: elementId)
            break
        default:
            elementQuery = app.staticTexts.matching(identifier: elementId)
            break
        }
        return elementQuery
    }
}

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        sleep(2)
        self.typeText(deleteString)
        self.typeText(text)
    }
    
    func visible() -> Bool {
        guard self.exists && self.isHittable && !self.frame.isEmpty else
        {
            return false
        }
        
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}


