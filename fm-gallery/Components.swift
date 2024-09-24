//
//  Components.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//

import SwiftUI

enum Period: String, CaseIterable, Identifiable {
    case overall
    case week_1 = "7day"
    case month_1 = "1month"
    case month_3 = "3month"
    case month_6 = "6month"
    case year = "12month"
    var id: Self { self }
}

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
