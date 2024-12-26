//
//  PlaylistView.swift
//  njoy
//

import SwiftUI

// Main view for displaying the playlist and controlling the stream
struct PlaylistView: View {
    @StateObject private var viewModel = PlaylistViewModel() // ViewModel for handling playlist data
    
    var body: some View {
        ZStack {
            // Apply the system gray background
            Color(.systemGroupedBackground)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                if geometry.size.width > geometry.size.height {
                    // Landscape Layout
                    HStack(spacing: 20) {
                        LogoView(viewModel: viewModel) // Pass ViewModel to LogoView
                            .frame(width: geometry.size.width * 0.3) // Occupies 30% of the width
                        contentView() // Playlist and controls
                    }
                } else {
                    // Portrait Layout
                    VStack(spacing: 20) {
                        LogoView(viewModel: viewModel) // Pass ViewModel to LogoView
                            .frame(height: geometry.size.height * 0.2) // Occupies 20% of the height
                        contentView() // Playlist and controls
                    }
                }
            }
        }
        .onAppear {
            // Fetch playlist data and current show title when the view appears
            viewModel.fetchPlaylist()
            viewModel.fetchCurrentTitle()
            
            // Set up the audio player
            AudioPlayerManager.shared.setupPlayer()
        }
    }
    
    // Main content (playlist and controls)
    @ViewBuilder
    private func contentView() -> some View {
        VStack {
            // Show a loading indicator while the playlist is being fetched
            if viewModel.isLoading {
                ProgressView("Lade Playlist...") // "Loading playlist..."
                    .padding()
            }
            // Show an error message if there was an issue fetching the playlist
            else if let error = viewModel.errorMessage {
                Text("Fehler: \(error)") // "Error: \(error)"
                    .foregroundColor(.red)
                    .padding()
            }
            // Display the playlist once data is successfully fetched
            else {
                ScrollView {
                    VStack(spacing: 20) {
                        // Loop through the list of songs and display them
                        ForEach(viewModel.songs.indices, id: \.self) { index in
                            SongView(song: viewModel.songs[index], isCurrent: index == 1) // Highlight current song
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
            
            Spacer()
            
            // Control view for starting/stopping the radio stream
            StreamControlView()
                .padding()
        }
    }
}

struct LogoView: View {
    @ObservedObject var viewModel: PlaylistViewModel // ViewModel to fetch and display the current show title

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://www.ndr.de/media/njoylivestream102_v-contentgross.jpg")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Color.red // Show a red placeholder in case of an error
                } else {
                    ProgressView() // Show a loading indicator while the image loads
                }
            }
            .cornerRadius(10) // Optional rounded corners
            
            // Display the current show title
            Text(viewModel.currentTitle)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.top, 8) // Space between the logo and the title
        }
    }
}

// View to display individual songs in the playlist
struct SongView: View {
    let song: Song // Song data
    let isCurrent: Bool // Indicates if this song is the currently playing one
    
    var body: some View {
        HStack {
            // Asynchronous image loading for the song cover
            AsyncImage(url: song.coverURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit() // Show the image when successfully loaded
                } else if phase.error != nil {
                    Color.red // Show a red placeholder in case of an error
                } else {
                    ProgressView() // Show a loading indicator while the image loads
                }
            }
            .frame(width: 60, height: 60) // Fixed size for song cover
            .cornerRadius(8) // Rounded corners for the image
            
            VStack(alignment: .leading) {
                // Display song title with different styles for the current song
                Text(song.title)
                    .font(isCurrent ? .headline : .subheadline)
                    .fontWeight(isCurrent ? .bold : .regular)
                    .accessibilityIdentifier("SongTitleLabel")
                // Display song artist
                Text(song.interpret)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .accessibilityIdentifier("SongArtistLabel")
            }
            Spacer()
        }
        .padding()
        // Highlight the background for the currently playing song
        .background(isCurrent ? Color("NJoyGreen").opacity(0.5) : Color.clear)
        .cornerRadius(10) // Rounded corners for the song row
    }
}
