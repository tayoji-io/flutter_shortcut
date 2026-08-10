// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_shortcut_plus",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "flutter-shortcut-plus", targets: ["flutter_shortcut_plus"])
    ],
    // ponytail: no FlutterFramework dependency, so Flutter <3.44 SPM users still build.
    dependencies: [],
    targets: [
        .target(
            name: "flutter_shortcut_plus"
        )
    ]
)
