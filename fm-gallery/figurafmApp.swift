//
//  fm_galleryApp.swift
//  fm-gallery
//
//  Created by Léo Gillet on 09/09/2024.
//

import SwiftUI

@main
struct figurafmApp: App {
    @StateObject var settings = Settings()
    var body: some Scene {
        WindowGroup {
            TabView {
                ScrobblesView()
                    .tabItem {
                        Label {
                            Text("Scrobbles")
                                .font(.body)
                                .foregroundStyle(.primary)
                        } icon: {
                            Image(systemName: "music.note.list")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.primary)
                        }
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(8)
                    }
                    .environmentObject(settings)
                ChartsView()
                    .tabItem {
                        Label {
                            Text("Charts")
                                .font(.body)
                                .foregroundColor(.primary)
                        } icon: {
                            Image(systemName: "list.number")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.primary)
                        }
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(8)
                        .environmentObject(settings)
                    }
                    .environmentObject(settings)
            }
        }
    }
}
