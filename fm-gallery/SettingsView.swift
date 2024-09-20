//
//  SettingsView.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section(header: Text("Personal Settings")
                    .font(.headline)
                    .foregroundStyle(.primary))
                {
                    HStack {
                        Text("Username")
                        TextField("", text: $settings.user)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            Divider()
            Section(header: Text("About")
                .font(.headline)
                .foregroundStyle(.primary)
                .padding()) {
                    HStack {
                        Text("App Version:")
                        Spacer()
                        Text("\(String($settings._appVersionBundle.wrappedValue)).\(String($settings._appBuildVersionBundle.wrappedValue))")
                    }
                    HStack {
                        Text("Build Date:")
                        Spacer()
                        Text("Unreleased")
                    }
                    HStack(spacing: 0) {
                        Text("Developed by ")
                        Link("Léo Gillet", destination: URL(string: "https://leogillet.com")!)
                        Spacer()
                    }
            }
                .padding(.horizontal)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    SettingsView().environmentObject(Settings())
}
