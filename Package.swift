// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedFramework",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SharedFramework",
            targets: ["SharedFramework"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "SharedFramework",
            dependencies: []),
        .testTarget(
            name: "SharedFrameworkTests",
            dependencies: ["SharedFramework"]),
    ]
)
