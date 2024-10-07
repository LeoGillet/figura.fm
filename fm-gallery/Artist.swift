//
//  Artist.swift
//  fm-gallery
//
//  Created by Léo Gillet on 07/10/2024.
//

import SwiftUI

struct TopArtistRow: View {
    var artist: LastFMAPITopArtistsArtist
    
    var body: some View {
        HStack {
            switch artist.attr.rank {
            case "1":
                Image(systemName: "trophy.fill")
                    .foregroundStyle(.gold)
                    .frame(width: 20)
            
            case "2":
                Image(systemName: "medal.fill")
                    .foregroundStyle(.silver)
                    .frame(width: 20)
                
            case "3":
                Image(systemName: "medal.fill")
                    .foregroundStyle(.bronze)
                    .frame(width: 20)
                
            default:
                Text(artist.attr.rank)
                    .frame(width: 20)
            }
            
            VStack(alignment: .leading) {
                Text(artist.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text("\(artist.playcount) scrobbles")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
