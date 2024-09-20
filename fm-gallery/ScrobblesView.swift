//
//  ContentView.swift
//  fm-gallery
//
//  Created by Léo Gillet on 09/09/2024.
//

import SwiftUI

struct ScrobblesView: View {
    @StateObject private var trackViewModel = TracksViewModel()
    @State private var showSettings = false
    @State private var tracks: [LastFMAPITrack] = []
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(onSettingsTap: {
                showSettings.toggle()
            })
            if (settings.apiKey != "") {
                NavigationView {
                    ScrollView {
                        if let error = trackViewModel.errorMessage {
                            VStack {
                                Text("Error: \(error)")
                                    .foregroundStyle(.red)
                                    .padding()
                            }
                            .padding()
                        } else {
                            VStack(spacing: 5) {
                                ForEach(tracks) { track in
                                    HStack {
                                        TrackRow(track: track)
                                    }
                                }
                            }
                            .task {
                                if ($settings.user.wrappedValue != "") {
                                    await trackViewModel.loadRecentTracks(user: $settings.user.wrappedValue)
                                    tracks = trackViewModel.tracks
                                }
                            }
                        }
                    }
                    .refreshable {
                        await trackViewModel.loadRecentTracks(user: $settings.user.wrappedValue)
                        tracks = trackViewModel.tracks
                    }
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
        }
    }
}


#Preview {
    ScrobblesView()
        .environmentObject(Settings())
}
