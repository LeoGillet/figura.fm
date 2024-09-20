//
//  Song.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//
import SwiftUI

struct TrackRow: View {
    var track: LastFMAPITrack
    
    var body: some View {
        let nowPlaying = track.attr?.nowplaying == "true"
        HStack {
            /*
            song.cover
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(2)
            */
            AsyncImage(url: URL(string: track.image[track.image.count - 1].text)) {
                image in image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 50, height: 50)
                .cornerRadius(2)
            
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text("\(track.artist.text) - \(track.album.text)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            Spacer()
            if (nowPlaying) {
                Image(systemName: "waveform")
                    .symbolEffect(.variableColor.iterative.dimInactiveLayers.nonReversing)
                
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .background(nowPlaying ? Color(Color.yellowBg1) : Color(.systemBackground))
    }
    
}
