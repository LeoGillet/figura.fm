//
//  TrackViewModel.swift
//  fm-gallery
//
//  Created by Léo Gillet on 20/09/2024.
//

import SwiftUI
import Combine

@MainActor
class TracksViewModel: ObservableObject {
    @Published var tracks: [LastFMAPITrack] = []
    @Published var errorMessage: String? = nil
    
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
