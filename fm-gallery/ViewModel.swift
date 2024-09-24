//
//  ViewModel.swift
//  fm-gallery
//
//  Created by Léo Gillet on 20/09/2024.
//

import SwiftUI
import Combine

@MainActor
class TrackHistoryViewModel: ObservableObject {
    @Published var tracks: [LastFMAPITrack] = []
    @Published var errorMessage: String? = nil
    @EnvironmentObject var settings: Settings
    
    func loadRecentTracks(user: String) async {
        do {
            if (user == "") {
                fatalError("No username entered in settings")
            }
            let recentTracks = try await requestAndDecodeRecentTracks(user: user)
            self.tracks = recentTracks.tracks
        } catch {
            self.errorMessage = String(describing: error)
        }
    }
}

@MainActor
class TopAlbumViewModel: ObservableObject {
    @Published var albums: [LastFMAPITopAlbumsAlbum] = []
    @Published var errorMessage: String? = nil
    @EnvironmentObject var settings: Settings
    
    func loadTopAlbums(user: String, period: String) async {
        do {
            if (user == "") {
                fatalError("No username entered in settings")
            }
            let topAlbums = try await requestAndDecodeTopAlbums(user: user, period: period)
            self.albums = topAlbums.albums
        } catch {
            self.errorMessage = String(describing: error)
        }
    }
}
