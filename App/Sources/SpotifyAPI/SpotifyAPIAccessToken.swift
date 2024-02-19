//
//  SpotifyAPIAccessToken.swift
//
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import Foundation

public struct SpotifyAPIAccessToken: Codable {
    public let accessToken: String
    public let tokenType: String
    public let expiresIn: Int
}
