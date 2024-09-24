//
//  ContentView.swift
//  fm-gallery
//
//  Created by Léo Gillet on 09/09/2024.
//

import SwiftUI

struct ScrobblesView: View {
    @State private var showSettings = false
    @State private var tracks: [LastFMAPITrack] = []
    @EnvironmentObject var settings: Settings
    @StateObject private var trackHistoryViewModel = TrackHistoryViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(onSettingsTap: {
                showSettings.toggle()
            })
            if (settings.apiKey != "") {
                NavigationView {
                    ScrollView {
                        if let error = trackHistoryViewModel.errorMessage {
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
                                    await trackHistoryViewModel.loadRecentTracks(user: $settings.user.wrappedValue)
                                    tracks = trackHistoryViewModel.tracks
                                }
                            }
                        }
                    }
                    .refreshable {
                        await trackHistoryViewModel.loadRecentTracks(user: $settings.user.wrappedValue)
                        tracks = trackHistoryViewModel.tracks
                    }
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
}


#Preview {
    ScrobblesView()
        .environmentObject(Settings())
}
