// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Swift 5.1 is Mojave and newer

import PackageDescription

let package = Package(
    name: "trash",
    platforms: [
        .macOS(.v10_12)
    ],
    products: [
        .executable(name: "trash", targets: ["trash"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "trash",
            dependencies: [],
            path: "trash/" // omit or override if needed
            ),
    ],
    swiftLanguageVersions: [
      .v5
    ]
)
