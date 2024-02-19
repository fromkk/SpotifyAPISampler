//
//  ContentView.swift
//  SpotifyAPISampler
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import SwiftUI
import SpotifyAPI

struct ContentView: View {
    @State var isLoading: Bool = false
    @State var tracks: [SpotifyTrack] = []
    @State var keyword: String = ""
    @State var hasError: Bool = false

    private var apiClient: SpotifyAPIClient = DefaultSpotifyAPIClient()

    var body: some View {
        NavigationStack {
            ScrollView {
                MusicSearchTextView(text: $keyword) {
                    search()
                }

                if isLoading {
                    ProgressView()
                }
                else {
                    LazyVStack(spacing: 16) {
                        ForEach(tracks) { track in
                            SpotifyItemView(track: track) {
                                print("Selected \(track)")
                            }
                        }
                    }
                    .padding(16)
                }
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle(Text("Music selection"))
            .navigationBarTitleDisplayMode(.inline)
            .alert("Search failed", isPresented: $hasError, actions: {
                Button(action: {}, label: {
                    Text("OK")
                })
            })
        }
    }

    private func search() {
        guard !keyword.isEmpty else { return }
        Task {
            self.isLoading = true
            defer {
                self.isLoading = false
            }
            do {
                self.tracks = try await apiClient.search(keyword)
            } catch {
                self.hasError = true
            }
        }
    }
}

#Preview {
    ContentView()
}
