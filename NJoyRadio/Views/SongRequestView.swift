//
//  SongRequestView.swift
//  njoy
//

import SwiftUI

// This struct defines the SongRequestView, which is a SwiftUI view.
struct SongRequestView: View {
    // A state object for managing the view model that handles song request data.
    @StateObject private var viewModel = SongRequestViewModel()
    
    var body: some View {
        // The main view is embedded in a navigation view.
        NavigationView {
            VStack {
                // The form contains user inputs for the song request.
                Form {
                    // Section for entering song details (title and artist).
                    Section(header: Text("Song Details")) {
                        TextField("Song Titel", text: $viewModel.songTitle) // TextField for the song title.
                        TextField("Interpret", text: $viewModel.songInterpret) // TextField for the artist name.
                    }
                    
                    // Section for entering user information (name and email).
                    Section(header: Text("Deine Informationen")) {
                        TextField("Name", text: $viewModel.userName) // TextField for the user's name.
                        TextField("E-Mail", text: $viewModel.userEmail) // TextField for the user's email.
                            .keyboardType(.emailAddress) // Keyboard optimized for email input.
                    }
                    
                    // Button for submitting the song request.
                    Section {
                           Button(action: {
                               viewModel.submitSongRequest() // Calls the function to handle submission.
                           }) {
                               Text("Senden") // Button label.
                                   .frame(maxWidth: .infinity) // Takes the full width
                                   .padding()
                                   .background(Color("NJoyGreen"))
                                   .foregroundColor(.white)
                                   .cornerRadius(8)
                           }
                           .frame(maxWidth: .infinity, alignment: .center) // Adjusts the button's width to fit
                           .listRowInsets(EdgeInsets()) // Removes additional spacing
                       }
                       .listRowBackground(Color.clear) // Removes the row background
                   }
                    
                
                // Shows a success message if the submission was successful.
                if viewModel.isSubmitted {
                    Text("Dein Songwunsch wurde gesendet!") // Success message.
                        .foregroundColor(.green) // Green text color.
                        .padding() // Adds padding around the text.
                }
                
                // Shows an error message if there's an error in the process.
                if let error = viewModel.errorMessage {
                    Text("Fehler: \(error)") // Displays the error message.
                        .foregroundColor(.red) // Red text color for errors.
                        .padding() // Adds padding around the text.
                }
            }
            .navigationTitle("Song Wünschen") // Sets the title of the navigation bar.
        }
    }
}
