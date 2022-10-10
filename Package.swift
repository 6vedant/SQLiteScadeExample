// swift-tools-version:5.3

import PackageDescription
import Foundation

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let package = Package(
    name: "SQLiteScadeExample",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "SQLiteScadeExample",
            type: .static,
            targets: [
                "SQLiteScadeExample"
            ]
        )
    ],
    dependencies: [
      .package(url: "https://github.com/scadedoc/SQLite.swift", .branch("master"))
    ],
    targets: [
        .target(
            name: "SQLiteScadeExample",
            dependencies: [.product(name: "SQLite", package: "SQLite.swift")],
            exclude: ["main.page"],
            swiftSettings: [
                .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
                .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
            ]
        )
    ]
)