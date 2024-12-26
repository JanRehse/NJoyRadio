//
//  FeedbackView.swift
//  njoy
//

import SwiftUI

// Main view for the feedback section
struct FeedbackView: View {
    @StateObject private var viewModel = FeedbackViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground) 
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Loading moderator image...")
                            .padding()
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        if geometry.size.width > geometry.size.height {
                            HStack(alignment: .top, spacing: 20) {
                                ModeratorImageView(url: viewModel.moderatorImageURL)
                                FeedbackForm(viewModel: viewModel)
                            }
                            .padding()
                            .accessibilityIdentifier("ModeratorImageView")
                        } else {
                            VStack(alignment: .center, spacing: 20) {
                                ModeratorImageView(url: viewModel.moderatorImageURL)
                                FeedbackForm(viewModel: viewModel)
                            }
                            .padding()
                            .accessibilityIdentifier("ModeratorImageView")
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchModeratorImage()
        }
    }
}

// View for displaying the moderator's image
struct ModeratorImageView: View {
    let url: URL?
    
    var body: some View {
        if let url = url {
            // Asynchronous loading of the image
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    // Display the loaded image
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    // Show a red box if there's an error
                    Color.red
                } else {
                    // Show a progress indicator while loading
                    ProgressView()
                }
            }
            .frame(width: 250, height: 250) // Fixed size for the image
            .cornerRadius(10) // Rounded corners
        }
    }
}

// Form for submitting feedback
struct FeedbackForm: View {
    @ObservedObject var viewModel: FeedbackViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Section for rating the playlist
            VStack(alignment: .leading) {
                Text("Playlist Bewertung")
                RatingView(rating: $viewModel.playlistRating)
            }
            
            // Section for rating the moderation
            VStack(alignment: .leading) {
                Text("Moderation Bewertung")
                RatingView(rating: $viewModel.moderationRating)
            }
            
            // Section for adding a comment
            VStack(alignment: .leading) {
                Text("Kommentar")
                TextField("Dein Feedback...", text: $viewModel.comment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Submit button
            Button(action: {
                viewModel.submitFeedback()
            }) {
                Text("Senden")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("NJoyGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .accessibilityIdentifier("Senden")
            }
            .padding(.top, 10)
        }
        .padding()
    }
}

// Custom view for displaying a star-based rating system
struct RatingView: View {
    @Binding var rating: Int
    
    var maximumRating = 5 // Maximum number of stars
    var offImage: Image? // Optional image for empty stars
    var onImage = Image(systemName: "star.fill") // Default image for filled stars
    var offColor = Color.gray // Color for empty stars
    var onColor = Color.yellow // Color for filled stars
    
    var body: some View {
        HStack {
            // Generate stars dynamically
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor) // Set color based on rating
                    .onTapGesture {
                        rating = number // Update rating when a star is tapped
                    }
            }
        }
    }
    
    // Determine which image to show for each star
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? Image(systemName: "star") // Empty star
        } else {
            return onImage // Filled star
        }
    }
}
