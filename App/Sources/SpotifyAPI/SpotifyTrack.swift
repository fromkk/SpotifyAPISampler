//
//  SpotifyTrack.swift
//
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import Foundation

public struct SpotifyTrack: Hashable, Sendable, Identifiable {
    public init(
        id: String? = nil,
        title: String? = nil,
        artistName: String? = nil,
        uri: String? = nil,
        artworkUrl: URL? = nil,
        previewUrl: URL? = nil,
        href: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.uri = uri
        self.artworkUrl = artworkUrl
        self.previewUrl = previewUrl
        self.href = href
    }
    public var id: String?
    public var title: String?
    public var artistName: String?
    public var uri: String?
    public var artworkUrl: URL?
    public var previewUrl: URL?
    public var href: URL?
}
