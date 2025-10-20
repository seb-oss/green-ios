// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SebGreenComponents",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SebGreenComponents",
            targets: ["SebGreenComponents"]
        ),
    ],
    dependencies: [
//        .package(url: "https://github.com/seb-oss/green-tokens-ios", .upToNextMajor(from: "0.10.3"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SebGreenComponents",
            dependencies: [
//                .product(name: "GreenTokens", package: "green-tokens-ios"),
            ],
            resources: [.process("Resources")]
        ),
    ]
)
