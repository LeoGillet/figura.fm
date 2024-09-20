//
//  ChartsView.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//
import SwiftUI

struct ChartsView: View {
    @State private var showSettings = false
    
    var body: some View {
        VStack(spacing: 0) {
            TopBar(onSettingsTap: {
                showSettings.toggle()
            })
            
            Spacer()
        }
        .sheet(isPresented: $showSettings) {
                SettingsView()
        }
    }
}

#Preview {
    ChartsView()
}
