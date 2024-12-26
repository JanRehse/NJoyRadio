//
//  AudioPlayerManager.swift
//  njoy
//

import Foundation
import AVFoundation
import Combine

// Singleton class that manages audio playback using AVPlayer
class AudioPlayerManager: ObservableObject {
    static let shared = AudioPlayerManager() // Singleton instance of the audio player manager
    
    private var player: AVPlayer? // AVPlayer instance for streaming audio
    @Published var isPlaying: Bool = false // Tracks whether the audio is currently playing, binds to UI
    
    private var cancellables = Set<AnyCancellable>() // Stores Combine subscriptions to manage memory
    
    // Private initializer to enforce the singleton pattern
    private init() {}

    // Sets up the audio player and starts observing its status
    func setupPlayer() {
        configureAudioSession() // Configures the app's audio session for playback
        
        // Ensure the URL for the audio stream is valid
        guard let url = URL(string: "https://icecast.ndr.de/ndr/njoy/live/mp3/128/stream.mp3") else { return }
        player = AVPlayer(url: url) // Initialize the player with the audio stream URL
        
        // Observe the player's status to respond to changes (e.g., ready to play or failed)
        player?.currentItem?.publisher(for: \.status)
            .receive(on: DispatchQueue.main) // Ensure UI updates are performed on the main thread
            .sink { [weak self] status in
                if status == .readyToPlay {
                    // Start playback when the player is ready
                    self?.player?.play()
                    self?.isPlaying = true
                } else if status == .failed {
                    // Handle failure by stopping playback
                    self?.isPlaying = false
                }
            }
            .store(in: &cancellables) // Store the subscription to prevent memory leaks
    }

    // Configures the audio session for background playback
    private func configureAudioSession() {
        do {
            // Set the audio session category to playback
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            // Activate the audio session
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            // Log any errors that occur during configuration
            print("Audio Session Error: \(error)")
        }
    }

    // Starts audio playback
    func play() {
        player?.play() // Start the AVPlayer
        isPlaying = true // Update the playing state
    }

    // Pauses audio playback
    func pause() {
        player?.pause() // Pause the AVPlayer
        isPlaying = false // Update the playing state
    }
}
