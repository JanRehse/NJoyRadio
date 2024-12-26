//
//  NJoyRadioUITestsLaunchTests.swift
//  NJoyRadioUITests
//

import XCTest

final class NJoyRadioUITestsLaunchTests: XCTestCase {

    // This property ensures that the test will run for each UI configuration.
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // This method is called before each test is run.
    // It ensures that the test will stop immediately if a failure occurs.
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    /**
     * This test method launches the app, verifies the presence of the "Music" tab,
     * and captures a screenshot of the launch screen.
     */
    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Check if the "Music" tab is visible on the tab bar.
        let tabBar = app.tabBars
        XCTAssertTrue(tabBar.buttons["Musik"].exists, "The 'Music' tab should be present at app launch.")

        // Additional steps can be added here, such as navigating through the app or checking other UI elements.

        // Take a screenshot of the launch screen.
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Launch Screen"  // Name for the screenshot attachment.
        attachment.lifetime = .keepAlways  // Keep the screenshot for future reference.
        add(attachment)
    }
}
