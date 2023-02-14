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
    targets: [
        .target(name: "AttributedStringBuilder"),
        .testTarget(name: "AttributedStringBuilderTests", dependencies: ["AttributedStringBuilder"]),
    ]
)
