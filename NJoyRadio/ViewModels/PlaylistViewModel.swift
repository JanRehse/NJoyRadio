//
//  PlaylistViewModel.swift
//  njoy
//

import Foundation
import Combine

// ViewModel responsible for managing the playlist data and state
class PlaylistViewModel: ObservableObject {
    // Published properties to update the UI automatically when their values change
    @Published var songs: [Song] = [] // Holds the list of songs in the playlist
    @Published var isLoading: Bool = false // Indicates whether the playlist is currently being loaded
    @Published var errorMessage: String? = nil // Stores error messages in case of a fetch failure
    @Published var currentTitle: String = "Loading..." // Holds the current show title

    // Function to fetch the playlist from the API
    func fetchPlaylist() {
        // Set loading state to true before starting the fetch
        isLoading = true
        
        // Call the API service to fetch the playlist
        APIService.shared.fetchPlaylist { [weak self] result in
            // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                // Reset the loading state once the fetch is complete
                self?.isLoading = false
                
                // Handle the result of the API call
                switch result {
                case .success(let songs):
                    // Update the playlist with the fetched songs
                    self?.songs = songs
                case .failure(let error):
                    // Store the error message to display to the user
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // Function to fetch the current show title from the API
    func fetchCurrentTitle() {
        // Call the API service to fetch the current title
        APIService.shared.fetchCurrentShowTitle { [weak self] result in
            // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    // Update the current title
                    self?.currentTitle = title
                case .failure(let error):
                    // Set an error message if fetching the title fails
                    self?.currentTitle = "Error loading title: \(error.localizedDescription)"
                }
            }
        }
    }
}
