//
//  MainView.swift
//  njoy
//

import SwiftUI

// MainView defines the primary view of the app with a tabbed interface
struct MainView: View {
    var body: some View {
        // TabView provides a tabbed navigation interface
        TabView {
            // First tab: Playlist view
            PlaylistView()
                .tabItem {
                    // Icon for the Playlist tab
                    Image(systemName: "music.note")
                    // Label for the Playlist tab
                    Text("Musik") // Displays "Music" in German
                }

            // Second tab: Feedback view
            FeedbackView()
                .tabItem {
                    // Icon for the Feedback tab
                    Image(systemName: "star")
                    // Label for the Feedback tab
                    Text("Bewerten") // Displays "Rate" in German
                }

            // Third tab: Song request view
            SongRequestView()
                .tabItem {
                    // Icon for the Song Request tab
                    Image(systemName: "plus.circle")
                    // Label for the Song Request tab
                    Text("Wünschen") // Displays "Request" in German
                }
        }
        .accentColor(Color("NJoyGreenDark"))
    }
}
