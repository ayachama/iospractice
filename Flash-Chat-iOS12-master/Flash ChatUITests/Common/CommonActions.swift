//
//  CommonActions.swift
//  Flash ChatUITests
//
//  Created by Avinash Yachamaneni on 12/20/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import XCTest
public class CommonActions {
    
    var xcTestLocal: XCTestCase
    var app: XCUIApplication
    
    init(xcTest: XCTestCase, app: XCUIApplication) {
        self.xcTestLocal = xcTest
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

    public func tap(elementType: Int, elementId: String, app: XCUIApplication) {
        if let element: XCUIElement = fetchElement(elementType: elementType, elementId: elementId) {
            element.tap()
        }
    }
    
    public func waitForElementAsync(elementType: Int, elementId: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
            XCTWaiter.wait(for: [expect1, expect2], timeout: 10)
        }
    }
    
    public func waitSafeForElementAsync(elementType: Int, elementId: String, app: XCUIApplication) -> Bool? {
        var isFound: Bool = true
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 10)
            if result == .timedOut {
                isFound = false
            }
        }
        return isFound
    }
    
    public func dragElementUp(elementType: Int, elementId: String, app: XCUIApplication, toElement: XCUIElement) {
        if let element: XCUIElement = fetchElement(elementType: elementType, elementId: elementId) {
            self.app = app
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
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
    
    public func dragElementUp(elementType: Int, elementId: String, app: XCUIApplication) {
        if let element: XCUIElement = fetchElement(elementType: elementType, elementId: elementId) {
            self.app = app
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 10)
            if result != .timedOut {
                if element.isHittable {
                    let start = element.coordinate(withNormalizedOffset: CGVector(dx: element.frame.midX, dy: element.frame.midY))
                    let finish = element.coordinate(withNormalizedOffset: CGVector(dx: element.frame.midX, dy: element.frame.midY + 100 ))
                    start.press(forDuration: 1, thenDragTo: finish)
                }
            }
        }
    }
    
    public func tapAsync(elementType: Int, elementId: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
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
    
    public func tapAsyncSafe(elementType: Int, elementId: String, app: XCUIApplication, timeOut: Double) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: timeOut)
            if result != .timedOut {
                element.firstMatch.tap()
            }
        }
    }
    
    public func sendText(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            element.tap()
            element.typeText(elementText)
        }
    }
    
    public func sendTextAsync(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
            let result = XCTWaiter.wait(for: [expect1, expect2], timeout: 10)
            if result != .timedOut {
                element.tap()
                element.typeText(elementText)
            }
        }
    }
    
    public func isElementVisible(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            XCTAssert(element.exists)
        }
    }
    
    public func isElementVisibleAsync(elementType: Int, elementId: String, elementText: String, app: XCUIApplication) {
        if let element: XCUIElement = getXCElement(elementType: elementType, elementId: elementId) {
            var isFound : Bool = true
            let exists1 = NSPredicate(format: "exists == 1")
            let exists2 = NSPredicate(format: "exists == true")
            let expect1 = xcTestLocal.expectation(for: exists1, evaluatedWith: element, handler: nil)
            let expect2 = xcTestLocal.expectation(for: exists2, evaluatedWith: element, handler: nil)
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
                if collectionViewElement.cells.element.waitForExistence(timeout: 1) == false {
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
                    if collectionViewElement.waitForExistence(timeout: 1) == false {
                        break
                    }
                }
            }
        }
        return rtn;
    }
    
    public func getXCElement(elementType: Int, elementId: String) -> XCUIElement? {
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
        case CommonActions.UI_VIEW:
            element = app.otherElements[elementId]
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
        case CommonActions.COLLECTION_VIEW:
            elementQuery = app.collectionViews.matching(identifier: elementId)
            break
        case CommonActions.TABLE_VIEW:
            elementQuery = app.tables.matching(identifier: elementId)
            break
        case CommonActions.TABLE_CELL:
            elementQuery = app.tables.cells.matching(identifier: elementId)
            break
        case CommonActions.UI_VIEW:
            elementQuery = app.otherElements.matching(identifier: elementId)
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
}

