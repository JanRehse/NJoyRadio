//
//  NJoyRadioTests.swift
//  njoyTests
//

import XCTest
@testable import NJoyRadio

class NJoyRadioTests: XCTestCase {

    /**
     * Test decoding a model (RadioPlaylistResponse).
     * This test checks if the RadioPlaylistResponse model can be correctly decoded
     * from the given JSON string.
     */
    func testRadioPlaylistResponseDecoding() throws {
        // Example JSON string for a playlist response
        let jsonString = """
        {
            "song_previous_interpret": "Artist1",
            "song_previous_title": "Song1",
            "song_previous_cover": "cover1",
            "song_now_interpret": "Artist2",
            "song_now_title": "Song2",
            "song_now_cover": "cover2",
            "song_next_interpret": "Artist3",
            "song_next_title": "Song3",
            "song_next_cover": "cover3"
        }
        """
        
        // Convert the JSON string into Data format
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert the example JSON into Data.")
            return
        }

        // Attempt to decode the JSON data into a RadioPlaylistResponse object
        do {
            let playlistResponse = try JSONDecoder().decode(RadioPlaylistResponse.self, from: jsonData)
            
            // Verify if the decoded values match the expected values
            XCTAssertEqual(playlistResponse.song_now_title, "Song2")
            XCTAssertEqual(playlistResponse.song_now_interpret, "Artist2")
            XCTAssertEqual(playlistResponse.song_previous_title, "Song1")
            XCTAssertEqual(playlistResponse.song_next_title, "Song3")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    /**
     * Test decoding a model (ModeratorImageResponse).
     * This test verifies that the ModeratorImageResponse model decodes correctly.
     */
    func testModeratorImageResponseDecoding() throws {
        let jsonString = """
        {
            "imageurl": "/images/moderator.jpg"
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert the example JSON into Data.")
            return
        }

        do {
            let imageResponse = try JSONDecoder().decode(ModeratorImageResponse.self, from: jsonData)
            // Check if the decoded image URL matches the expected value
            XCTAssertEqual(imageResponse.imageurl, "/images/moderator.jpg")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    /**
     * Test decoding a model (CurrentShowResponse).
     * This test checks if the CurrentShowResponse model decodes properly.
     */
    func testCurrentShowResponseDecoding() throws {
        let jsonString = """
        {
            "title": "Morning Show"
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert the example JSON into Data.")
            return
        }

        do {
            let showResponse = try JSONDecoder().decode(CurrentShowResponse.self, from: jsonData)
            // Ensure the decoded show title matches the expected value
            XCTAssertEqual(showResponse.title, "Morning Show")
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    /**
     * Example of a Decoding Test with incorrect data types.
     * This test checks if decoding fails when incorrect types are provided in the JSON.
     */
    func testRadioPlaylistResponseDecodingWithInvalidTypes() throws {
        let jsonString = """
        {
            "song_previous_interpret": 123, // Expected String, but an Integer is provided
            "song_previous_title": "Song1",
            "song_previous_cover": "cover1",
            "song_now_interpret": "Artist2",
            "song_now_title": "Song2",
            "song_now_cover": "cover2",
            "song_next_interpret": "Artist3",
            "song_next_title": "Song3",
            "song_next_cover": "cover3"
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert the example JSON into Data.")
            return
        }

        // Ensure that an error is thrown due to invalid data types
        XCTAssertThrowsError(try JSONDecoder().decode(RadioPlaylistResponse.self, from: jsonData)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }

}
