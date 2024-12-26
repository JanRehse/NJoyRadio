//
//  NJoyRadioUITests.swift
//  NJoyRadioUITests
//

import XCTest

final class NJoyRadioUITests: XCTestCase {

    // This method is called before each test is run.
    // If an error occurs, the test will stop immediately.
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // This method is called after each test is completed.
    // You can perform any necessary cleanup or logout here.
    override func tearDownWithError() throws {
        // Global cleanup or reset operations can go here.
    }

    /**
     * Test to verify the launch of the app and check if the expected views are visible.
     */
    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify that the "Music", "Rate", and "Wish" tabs are visible on the main screen.
        let tabBar = app.tabBars
        XCTAssertTrue(tabBar.buttons["Musik"].exists, "The 'Music' tab was not found.")
        XCTAssertTrue(tabBar.buttons["Bewerten"].exists, "The 'Rate' tab was not found.")
        XCTAssertTrue(tabBar.buttons["Wünschen"].exists, "The 'Wish' tab was not found.")
    }

    /**
     * Test to switch to the "Music" tab and verify if the song details (title and artist) are visible.
     */
    @MainActor
    func testSwitchToPlaylistAndCheckSongs() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars
        let musikTab = tabBar.buttons["Musik"]
        XCTAssertTrue(musikTab.exists, "The 'Music' tab was not found.")
        
        // Tap on the "Music" tab to switch to the music playlist view.
        musikTab.tap()

        // Wait for the song title to appear on the screen and verify it exists.
        let firstSongTitle = app.staticTexts["SongTitleLabel"].firstMatch
        let titleExists = firstSongTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(titleExists, "The expected song title was not found.")
        
        // Wait for the song artist to appear on the screen and verify it exists.
        let firstSongArtist = app.staticTexts["SongArtistLabel"].firstMatch
        let songExists = firstSongArtist.waitForExistence(timeout: 5)
        XCTAssertTrue(songExists, "The expected song artist was not found.")
    }

    /**
     * Test that opens the "Rate" tab, verifies the moderator image loads, and checks if a rating can be submitted.
     */
    @MainActor
    func testOpenFeedbackAndRate() throws {
        let app = XCUIApplication()
        app.launch()

        // Switch to the "Rate" tab.
        let tabBar = app.tabBars
        let feedbackTab = tabBar.buttons["Bewerten"]
        XCTAssertTrue(feedbackTab.exists, "The 'Rate' tab was not found.")
        feedbackTab.tap()

        // Wait for the moderator image to load and verify it exists.
        let moderatorImage = app.images["ModeratorImageView"]
        let imageExists = moderatorImage.waitForExistence(timeout: 10)
        XCTAssertTrue(imageExists, "The moderator image did not load or was not found.")

        // Tap on the "Send" button to submit the feedback.
        let sendButton = app.buttons["Senden"]
        XCTAssertTrue(sendButton.exists, "Send button not found.")
        sendButton.tap()
    }

    /**
     * Performance test for app launch to measure the time it takes to launch the app.
     */
    @MainActor
    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
