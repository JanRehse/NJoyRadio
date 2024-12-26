//
//  APIService.swift
//  njoy
//

import Foundation

// Enum for handling API-related errors
enum APIError: Error {
    case invalidURL // Error for an invalid URL
    case noData // Error for missing data from the response
}

// Singleton class for handling API requests
class APIService {
    static let shared = APIService() // Singleton instance for global access

    // Private initializer to enforce the singleton pattern
    private init() {}

    // Fetches the playlist from the API
    func fetchPlaylist(completion: @escaping (Result<[Song], Error>) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: "https://www.ndr.de/public/radioplaylists/njoy.json") else {
            // Return an error if the URL is invalid
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Start a URL session to fetch data
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors returned from the network call
            if let error = error {
                completion(.failure(error))
                return
            }
            // Ensure the data is not nil
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            do {
                // Decode the JSON response into a `RadioPlaylistResponse` object
                let decoded = try JSONDecoder().decode(RadioPlaylistResponse.self, from: data)
                
                // Construct song objects using the decoded data
                let baseCoverURL = "https://www.ndr.de/public/radioplaylists/coverimages/"
                let songs = [
                    Song(
                        interpret: decoded.song_previous_interpret,
                        title: decoded.song_previous_title,
                        coverURL: URL(string: "\(baseCoverURL)\(decoded.song_previous_cover)_300x300.jpg")!
                    ),
                    Song(
                        interpret: decoded.song_now_interpret,
                        title: decoded.song_now_title,
                        coverURL: URL(string: "\(baseCoverURL)\(decoded.song_now_cover)_300x300.jpg")!
                    ),
                    Song(
                        interpret: decoded.song_next_interpret,
                        title: decoded.song_next_title,
                        coverURL: URL(string: "\(baseCoverURL)\(decoded.song_next_cover)_300x300.jpg")!
                    )
                ]
                // Pass the song list to the completion handler
                completion(.success(songs))
            } catch {
                // Handle decoding errors
                completion(.failure(error))
            }
        }.resume() // Start the data task
    }
    
    // Fetches the moderator's image URL from the API
    func fetchModeratorImage(completion: @escaping (Result<URL, Error>) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: "https://www.ndr.de/radio/titelanzeige100-totalblank_station-njoy.json") else {
            // Return an error if the URL is invalid
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Start a URL session to fetch data
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors returned from the network call
            if let error = error {
                completion(.failure(error))
                return
            }
            // Ensure the data is not nil
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            do {
                // Decode the JSON response into a `ModeratorImageResponse` object
                let decoded = try JSONDecoder().decode(ModeratorImageResponse.self, from: data)
                
                // Construct the full image URL
                let imageURL = URL(string: "https://www.ndr.de\(decoded.imageurl)")!
                
                // Pass the image URL to the completion handler
                completion(.success(imageURL))
            } catch {
                // Handle decoding errors
                completion(.failure(error))
            }
        }.resume() // Start the data task
    }
    
    // Fetches the current show title from the API
    func fetchCurrentShowTitle(completion: @escaping (Result<String, Error>) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: "https://www.ndr.de/radio/titelanzeige100-totalblank_station-njoy.json") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // Start a URL session to fetch data
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors returned from the network call
            if let error = error {
                completion(.failure(error))
                return
            }
            // Ensure the data is not nil
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            do {
                // Decode the JSON response into a `CurrentShowResponse` object
                let decoded = try JSONDecoder().decode(CurrentShowResponse.self, from: data)
                
                // Pass the title to the completion handler
                completion(.success(decoded.title))
            } catch {
                completion(.failure(error))
            }
        }.resume() // Start the data task
    }
}
