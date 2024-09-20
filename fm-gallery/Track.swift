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
        }
        .padding(.horizontal)
        .background(Color(.systemBackground))
    }
    
}
