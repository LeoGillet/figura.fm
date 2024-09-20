//
//  Components.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//

import SwiftUI

struct TopBar: View {
    var title: String = "figura.fm"
    var onSettingsTap: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
            
            Spacer()
            
            Button(action: onSettingsTap) {
                Image(systemName: "gear")
                    .foregroundStyle(.primary)
                    .font(.system(size: 24))
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview {
    TopBar(title: "figura.fm", onSettingsTap: {})
}
