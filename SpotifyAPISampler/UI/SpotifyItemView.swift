//
//  SpotifyItemView.swift
//  SpotifyAPISampler
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import SwiftUI
import SpotifyAPI

public struct SpotifyItemView: View {
    private let selected: () -> Void
    private let track: SpotifyTrack
    public init(track: SpotifyTrack, selected: @escaping () -> Void) {
        self.track = track
        self.selected = selected
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if let artworkUrl = track.artworkUrl {
                AsyncImage(
                    url: artworkUrl,
                    content: { phase in
                        phase.image?.resizable()
                    }
                )
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 8) {
                if let title = track.title {
                    Text(title)
                        .font(.title3.bold())
                        .foregroundStyle(Color(uiColor: .label))
                        .lineLimit(1)
                }

                if let artistName = track.artistName {
                    Text(artistName)
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(1)
                }
            }

            Spacer()

            Button {
                selected()
            } label: {
                Text("Select")
                    .font(.callout)
                    .foregroundStyle(Color(uiColor: .label))
            }
            .buttonStyle(SecondaryButtonStyle())

        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 16, height: 16)))
        .contentShape(Rectangle())
    }
}

#Preview {
    SpotifyItemView(track: SpotifyTrack(title: "Idol"), selected: {})
}
