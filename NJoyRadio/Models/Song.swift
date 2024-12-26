//
//  Song.swift
//  njoy
//

import Foundation

// Represents a song in the playlist or audio stream
struct Song: Identifiable {
    let id = UUID() // Unique identifier for each song, required for SwiftUI's List or ForEach
    let interpret: String // Name of the artist or band
    let title: String // Title of the song
    let coverURL: URL // URL pointing to the song's cover image
}
