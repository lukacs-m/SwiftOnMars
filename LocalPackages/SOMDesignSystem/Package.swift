// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("BareSlashRegexLiterals"),
    .enableUpcomingFeature("ConciseMagicFile"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("ForwardTrailingClosures"),
    .enableUpcomingFeature("ImplicitOpenExistentials"),
    .enableUpcomingFeature("StrictConcurrency"),
    .unsafeFlags(["-warn-concurrency", "-enable-actor-data-race-checks"])
]

let package = Package(name: "SOMDesignSystem",
                      platforms: [
                          .iOS(.v16)
                      ],
                      products: [
                          // Products define the executables and libraries a package produces, and make them
                          // visible to other packages.
                          .library(name: "SOMDesignSystem",
                                   targets: ["SOMDesignSystem"])
                      ],
                      dependencies: [
                          .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
                          .package(name: "NasaModels", path: "../NasaModels")
//                          .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0")
                      ],
                      targets: [
                          // Targets are the basic building blocks of a package. A target can define a module or a
                          // test suite.
                          // Targets can depend on other targets in this package, and on products in packages this
                          // package depends on.
                          .target(name: "SOMDesignSystem",
                                  dependencies: [
                                      .product(name: "NasaModels", package: "NasaModels"),
                                      .product(name: "Kingfisher", package: "Kingfisher")
                                  ],
                                  swiftSettings: swiftSettings
//                                  plugins: [
//                                      .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
//                                  ]
                          ),
                          .testTarget(name: "SOMDesignSystemTests",
                                      dependencies: ["SOMDesignSystem"])
                      ])
