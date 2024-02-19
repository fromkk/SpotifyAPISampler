//
//  AccessTokenMiddleWare.swift
//
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime
import OpenAPIURLSession

struct AccessTokenMiddleware: ClientMiddleware {
    private let accessToken: String
    public init(accessToken: String) {
        self.accessToken = accessToken
    }

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields.append(
            .init(name: HTTPField.Name("Authorization")!, value: "Bearer \(accessToken)")
        )
        return try await next(request, body, baseURL)
    }
}
