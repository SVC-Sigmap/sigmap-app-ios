//
//  sigmap_iosUITests.swift
//  sigmap-iosUITests
//
//  Created by Jack Puschnigg on 2023-01-25.
//

import XCTest

final class sigmap_iosUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLogin() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()

        let timeout = 2.0

        let emailInputField = app.textFields["loginEmail"]
        let passwordInputField = app.secureTextFields["loginPassword"]
        let loginButton = app.buttons["loginButton"]

        XCTAssertTrue(emailInputField.waitForExistence(timeout: timeout))
        XCTAssertTrue(passwordInputField.waitForExistence(timeout: timeout))
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))

        emailInputField.tap()
        emailInputField.typeText("Test@test.com")

        passwordInputField.tap()
        passwordInputField.typeText("password")
        
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))
        loginButton.tap()
        XCTAssertTrue(loginButton.isEnabled)
    }
    
    func testStartScanButton() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()

        let timeout = 2.0
        
        let emailInputField = app.textFields["loginEmail"]
        let passwordInputField = app.secureTextFields["loginPassword"]
        let loginButton = app.buttons["loginButton"]

        XCTAssertTrue(emailInputField.waitForExistence(timeout: timeout))
        XCTAssertTrue(passwordInputField.waitForExistence(timeout: timeout))
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))

        emailInputField.tap()
        emailInputField.typeText("Test@test.com")

        passwordInputField.tap()
        passwordInputField.typeText("password")
        
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))
        loginButton.tap()
        XCTAssertTrue(loginButton.isEnabled)

        let startScanButton = app.buttons["startScanButton"]
        XCTAssertTrue(startScanButton.waitForExistence(timeout: timeout))
        
        startScanButton.tap()
        XCTAssertTrue(startScanButton.isEnabled)
    }
    
    func testSettingsToggle() throws {
        let app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()

        let timeout = 2.0

        let emailInputField = app.textFields["loginEmail"]
        let passwordInputField = app.secureTextFields["loginPassword"]
        let loginButton = app.buttons["loginButton"]
        let settingsNavButton = app.tabBars.buttons.element(boundBy: 0)
        
        XCTAssertTrue(emailInputField.waitForExistence(timeout: timeout))
        XCTAssertTrue(passwordInputField.waitForExistence(timeout: timeout))
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))

        emailInputField.tap()
        emailInputField.typeText("Test@test.com")

        passwordInputField.tap()
        passwordInputField.typeText("password")
        
        XCTAssertTrue(loginButton.waitForExistence(timeout: timeout))
        loginButton.tap()
        XCTAssertTrue(loginButton.isEnabled)
        
        settingsNavButton.tap()
        
        XCTAssertTrue(app.switches["settingsToggle"].isEnabled)
    }
}
