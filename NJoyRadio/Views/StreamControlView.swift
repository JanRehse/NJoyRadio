//
//  StreamControlView.swift
//  njoy
//

import SwiftUI

// This struct defines the StreamControlView, which manages the play/pause button for the audio player
struct StreamControlView: View {
    // ObservedObject ensures the view updates whenever the state of the AudioPlayerManager changes
    @ObservedObject var audioPlayer = AudioPlayerManager.shared

    var body: some View {
        // A Button that toggles between play and pause actions
        Button(action: {
            if audioPlayer.isPlaying {
                // If the audio player is currently playing, pause it
                audioPlayer.pause()
            } else {
                // If the audio player is not playing, start playing
                audioPlayer.play()
            }
        }) {
            // Display an icon that changes depending on the audio player's state
            Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable() // Allows resizing of the image
                .frame(width: 50, height: 50) // Sets the width and height of the icon
                .foregroundColor(Color("NJoyGreen")) // Sets the color of the icon
        }
    }
}
