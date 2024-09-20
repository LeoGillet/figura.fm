//
//  Settings.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//

import SwiftUI

class Settings: ObservableObject {
    @Published var apiKey: String {
        didSet {
            UserDefaults.standard.set(apiKey, forKey: "APIKey")
        }
    }
    
    @Published var user: String {
        didSet {
            UserDefaults.standard.set(user, forKey: "User")
        }
    }
    
    @Published var _appVersionBundle: String
    @Published var _appBuildVersionBundle: String
    
    init() {
        // self.apiKey = UserDefaults.standard.string(forKey: "APIKey") ?? ""
        self.apiKey = "1221e324675b378a1d4161ad660b914d"
        self.user = UserDefaults.standard.string(forKey: "User") ?? ""
        self._appVersionBundle = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        self._appBuildVersionBundle = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
}
