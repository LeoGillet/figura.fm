//
//  Album.swift
//  fm-gallery
//
//  Created by Léo Gillet on 24/09/2024.
//

import SwiftUI

struct TopAlbumRow: View {
    var album: LastFMAPITopAlbumsAlbum
    
    var body: some View {
        HStack {
            switch album.attr.rank {
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
                Text(album.attr.rank)
                    .frame(width: 20)
            }
            
            AsyncImage(url: URL(string: album.images[album.images.count - 1].text)) {
                image in image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 50, height: 50)
                .cornerRadius(2)
                .shadow(radius: 2)
            
            VStack(alignment: .leading) {
                Text(album.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text("\(album.artist.name) - \(album.playcount) scrobbles")
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
