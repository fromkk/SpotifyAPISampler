//
//  SpotifyAPISamplerApp.swift
//  SpotifyAPISampler
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import SwiftUI
import SpotifyAPI

@main
struct SpotifyAPISamplerApp: App {
    init() {
        SpotifyAuth.clientId = nil // TODO: Set your Spotify clientId
        SpotifyAuth.clientSecret = nil // TODO: Set your Spotify clientSecret
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
