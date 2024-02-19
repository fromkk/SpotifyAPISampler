//
//  SpotifyAPIClient.swift
//
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public protocol SpotifyAPIClient {
    func search(_ q: String) async throws -> [SpotifyTrack]
}

public enum SpotifyAPIClientError: Error {
    case noClientId
    case noClientSecret
}

public final class DefaultSpotifyAPIClient: SpotifyAPIClient {
    public init() {}

    var cache: [String: SpotifyTrack] = [:]

    func token() async throws -> SpotifyAPIAccessToken {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)

        guard let clientId = SpotifyAuth.clientId else {
            throw SpotifyAPIClientError.noClientId
        }

        guard let clientSecret = SpotifyAuth.clientSecret else {
            throw SpotifyAPIClientError.noClientSecret
        }

        if let data = "\(clientId):\(clientSecret)".data(using: .utf8) {
            request.allHTTPHeaderFields = [
                "Authorization": "Basic \(data.base64EncodedString())",
                "Content-Type": "application/x-www-form-urlencoded",
            ]
        }
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        request.httpMethod = "POST"

        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        let (data, _) = try await urlSession.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(SpotifyAPIAccessToken.self, from: data)
        return result
    }

    public func search(_ q: String) async throws -> [SpotifyTrack] {
        let accessToken = try await token()
        let accessTokenMiddleware = AccessTokenMiddleware(accessToken: accessToken.accessToken)

        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [accessTokenMiddleware]
        )
        let headers = Operations.search.Input.Headers()
        let response = try await client.search(
            query: Operations.search.Input.Query(q: q, _type: [.track]),
            headers: headers
        )

        switch response {
        case let .ok(items):
            guard let tracks = try items.body.json.tracks?.value2.items else {
                return []
            }
            let results = tracks.map {
                SpotifyTrack(
                    id: $0.id,
                    title: $0.name,
                    artistName: $0.artists?.first?.name,
                    uri: $0.uri,
                    artworkUrl: $0.album?.value1.value1.images.first.flatMap {
                        URL(string: $0.url)
                    },
                    previewUrl: $0.preview_url.flatMap { URL(string: $0) },
                    href: $0.external_urls?.value1.spotify.flatMap { URL(string: $0) }
                )
            }

            results.forEach { track in
                if let id = track.id {
                    cache[id] = track
                }
            }

            return results
        default:
            return []
        }
    }
}
