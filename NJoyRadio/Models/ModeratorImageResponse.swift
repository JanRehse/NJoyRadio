//
//  ModeratorImageResponse.swift
//  njoy
//

import Foundation

// Represents the response structure for the moderator image API
// This struct is used to decode JSON data containing the URL of the moderator's image
struct ModeratorImageResponse: Decodable {
    let imageurl: String // The URL string for the moderator's image
}
struct CurrentShowResponse: Decodable {
    let title: String
}
