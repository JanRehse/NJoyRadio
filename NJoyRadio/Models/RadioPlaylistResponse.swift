//
//  RadioPlaylistResponse.swift
//  njoy
//

import Foundation

// Represents the response structure for the radio playlist API
// This struct is designed to decode JSON data returned by the API
struct RadioPlaylistResponse: Decodable {
    // Previous song information
    let song_previous_interpret: String // Name of the artist for the previous song
    let song_previous_title: String // Title of the previous song
    let song_previous_cover: String // Cover image filename for the previous song

    // Currently playing song information
    let song_now_interpret: String // Name of the artist for the currently playing song
    let song_now_title: String // Title of the currently playing song
    let song_now_cover: String // Cover image filename for the currently playing song

    // Next song information
    let song_next_interpret: String // Name of the artist for the next song
    let song_next_title: String // Title of the next song
    let song_next_cover: String // Cover image filename for the next song
}
