//
//  ChartsView.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//
import SwiftUI

struct ChartsView: View {
    @StateObject private var topAlbumViewModel = TopAlbumViewModel()
    @State private var showSettings = false
    @State private var albums: [LastFMAPITopAlbumsAlbum] = []
    @EnvironmentObject var settings: Settings
    
    @State var topAlbumsSelectedPeriod: Period = .month_1
    @State var topArtistsSelectedPeriod: Period = .month_1
    @State var topTracksSelectedPeriod: Period = .month_1
    
    func updateTopAlbums(period: String) async -> [LastFMAPITopAlbumsAlbum] {
        if ($settings.user.wrappedValue != "") {
            await topAlbumViewModel.loadTopAlbums(user: $settings.user.wrappedValue, period: period)
            return topAlbumViewModel.albums
        }
        return []
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(onSettingsTap: {
                showSettings.toggle()
            })
            
            if (settings.apiKey == "") {
                // No API key set: unable to send requests
            }
            else {
                NavigationView {
                    ScrollView {
                        if let error = topAlbumViewModel.errorMessage {
                            Text("Error: \(error)")
                                .foregroundStyle(.red)
                                .padding()
                        } else {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Top Albums")
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Picker("Period", selection: $topAlbumsSelectedPeriod) {
                                        Text("7 days").tag(Period.week_1)
                                        Text("1 month").tag(Period.month_1)
                                        Text("3 months").tag(Period.month_3)
                                        Text("6 months").tag(Period.month_6)
                                        Text("1 year").tag(Period.year)
                                        Text("All time").tag(Period.overall)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .pickerStyle(.menu)
                                
                                VStack(spacing: 5) {
                                    // Top Albums
                                    if (albums.isEmpty) {
                                        ProgressView()
                                    } else {
                                        ForEach(albums) { album in
                                            TopAlbumRow(album: album)
                                        }
                                    }
                                }
                                .task {
                                    albums = await updateTopAlbums(period: topAlbumsSelectedPeriod.rawValue)
                                    print(albums)
                                }
                                .onChange(of: topAlbumsSelectedPeriod) {
                                    Task {
                                        albums = await updateTopAlbums(period: topAlbumsSelectedPeriod.rawValue)
                                        print(albums)
                                    }
                                }
                                
                                Spacer()
                                VStack(spacing: 5) {
                                    // Top Artists
                                }
                                Spacer()
                                VStack(spacing: 5) {
                                    // Top Tracks
                                }
                            }
                        }
                    }
                    /*
                    .refreshable {
                        // ...
                    }
                     */
                }
                .navigationTitle("Top Albums")
            }
        }
        .sheet(isPresented: $showSettings) {
                SettingsView()
        }
    }
}

#Preview {
    ChartsView()
}
