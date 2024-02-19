// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "SpotifyAPI", targets: ["SpotifyAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.2.1"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.3.2"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.1"),
        .package(url: "https://github.com/apple/swift-http-types", from: "1.0.3"),
    ],
    targets: [
        .target(name: "SpotifyAPI", dependencies: [
            .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
            .product(name: "HTTPTypes", package: "swift-http-types"),
        ], resources: [
            .process("openapi-generator-config.yaml"),
            .process("openapi.yaml"),
        ], plugins: [
            .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
        ])
    ]
)
