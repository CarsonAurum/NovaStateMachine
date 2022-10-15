// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NovaStateMachine",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(name: "NovaStateMachine", targets: ["NovaStateMachine"]),
    ],
    dependencies: [
        .package(name: "NovaCore", path: "../NovaCore/")
    ],
    targets: [
        .target(
            name: "NovaStateMachine",
            dependencies: ["NovaCore"],
            path: "Sources/"
        ),
        .testTarget(
            name: "NovaStateMachineTests",
            dependencies: ["NovaStateMachine"],
            path: "Tests/"
        ),
    ]
)
