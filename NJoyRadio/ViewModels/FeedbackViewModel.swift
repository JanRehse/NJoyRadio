//
//  FeedbackViewModel.swift
//  njoy
//

import Foundation

// ViewModel for managing user feedback data and interactions
class FeedbackViewModel: ObservableObject {
    // Published properties for data binding with the UI
    @Published var playlistRating: Int = 0 // Stores the rating for the playlist (0–5)
    @Published var moderationRating: Int = 0 // Stores the rating for the moderation (0–5)
    @Published var comment: String = "" // Stores the user's feedback comment
    @Published var moderatorImageURL: URL? = nil // Holds the URL for the moderator's image
    @Published var isLoading: Bool = false // Tracks if data is being loaded
    @Published var errorMessage: String? = nil // Stores error messages, if any

    // Fetches the moderator's image from the API
    func fetchModeratorImage() {
        // Set loading state to true before starting the API call
        isLoading = true
        APIService.shared.fetchModeratorImage { [weak self] result in
            // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                // Reset loading state after API call completes
                self?.isLoading = false
                switch result {
                case .success(let url):
                    // Update the moderator image URL if successful
                    self?.moderatorImageURL = url
                case .failure(let error):
                    // Update the error message in case of failure
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // Submits the feedback data (to be implemented)
    func submitFeedback() {
        // Log feedback details to the console (placeholder for actual logic)
        print("Feedback sent: Playlist \(playlistRating), Moderation \(moderationRating), Comment: \(comment)")
    }
}
