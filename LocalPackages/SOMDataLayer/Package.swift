// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
   .enableUpcomingFeature("BareSlashRegexLiterals"),
   .enableUpcomingFeature("ConciseMagicFile"),
   .enableUpcomingFeature("ExistentialAny"),
   .enableUpcomingFeature("ForwardTrailingClosures"),
   .enableUpcomingFeature("ImplicitOpenExistentials"),
   .enableUpcomingFeature("StrictConcurrency"),
   .unsafeFlags(["-warn-concurrency", "-enable-actor-data-race-checks"]),
]

let package = Package(
    name: "SOMDataLayer",
    platforms: [
      .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SOMDataLayer",
            targets: ["SOMDataLayer"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/lukacs-m/SimpleNetwork", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/lukacs-m/SafeCache", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/lukacs-m/SimplySave", .upToNextMajor(from: "0.1.0")),
        .package(name: "SOMDomainLayer", path: "../SOMDomainLayer"),
        .package(name: "NasaModels", path: "../NasaModels"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SOMDataLayer",
            dependencies: [
                .product(name: "NasaModels", package: "NasaModels"),
                .product(name: "DomainInterfaces", package: "SOMDomainLayer"),
                .product(name: "SimpleNetwork", package: "SimpleNetwork"),
                .product(name: "SafeCache", package: "SafeCache"),
                .product(name: "SimplySave", package: "SimplySave"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "SOMDataLayerTests",
            dependencies: ["SOMDataLayer"]),
    ]
)
