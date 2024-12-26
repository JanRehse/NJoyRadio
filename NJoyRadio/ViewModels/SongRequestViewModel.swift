//
//  SongRequestViewModel.swift
//  njoy
//

import Foundation

// ViewModel for handling the Song Request feature
class SongRequestViewModel: ObservableObject {
    // Published properties to bind to the UI
    @Published var songTitle: String = "" // Stores the title of the requested song
    @Published var songInterpret: String = "" // Stores the name of the artist/interpreter of the song
    @Published var userName: String = "" // Stores the user's name
    @Published var userEmail: String = "" // Stores the user's email
    @Published var isSubmitted: Bool = false // Tracks whether the song request has been submitted
    @Published var errorMessage: String? = nil // Stores an error message if validation fails

    // Function to handle the submission of the song request
    func submitSongRequest() {
        // Validate that both songTitle and songInterpret are not empty
        guard !songTitle.isEmpty, !songInterpret.isEmpty else {
            // Set an error message if validation fails
            errorMessage = "Please enter both the song title and artist."
            return
        }
        
        // Simulate a successful submission with a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Mark the submission as successful
            self.isSubmitted = true
            
            // Reset the input fields after submission
            self.songTitle = ""
            self.songInterpret = ""
            self.userName = ""
            self.userEmail = ""
        }
    }
}
