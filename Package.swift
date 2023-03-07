// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AttributedStringBuilder",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "AttributedStringBuilder", targets: ["AttributedStringBuilder"]),
    ],
    dependencies: [
        .package(url: "https://github.com/chriseidhof/SwiftHighlighting", branch: "main"),
        .package(url: "https://github.com/apple/swift-markdown", branch: "main"),
    ],
    targets: [

        .target(
            name: "AttributedStringBuilder",
            dependencies: [
                .product(name: "SwiftHighlighting", package: "SwiftHighlighting"),
                .product(name: "Markdown", package: "swift-markdown"),
            ]),

        .testTarget(name: "AttributedStringBuilderTests", dependencies: ["AttributedStringBuilder"]),
    ]
)
