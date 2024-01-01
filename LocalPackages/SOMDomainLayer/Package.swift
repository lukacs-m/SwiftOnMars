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

let package = Package(name: "SOMDomainLayer",
                      platforms: [
                          .iOS(.v17)
                      ],
                      products: [
                          // Products define the executables and libraries a package produces, and make them
                          // visible to other packages.
                          .library(name: "SOMDomainLayer",
                                   targets: ["SOMDomainLayer"]),
                          .library(name: "DomainInterfaces",
                                   targets: ["DomainInterfaces"])
                      ],
                      dependencies: [
                          // Dependencies declare other packages that this package depends on.
                          .package(name: "NasaModels", path: "../NasaModels"),
                          .package(url: "https://github.com/krzysztofzablocki/Sourcery.git", from: "2.0.2")
                      ],
                      targets: [
                          // Targets are the basic building blocks of a package. A target can define a module or a
                          // test suite.
                          // Targets can depend on other targets in this package, and on products in packages this
                          // package depends on.
                          .target(name: "DomainInterfaces",
                                  dependencies: [
                                      .product(name: "NasaModels", package: "NasaModels")
                                  ]),
                          .target(name: "SOMDomainLayer",
                                  dependencies: [
                                      .product(name: "NasaModels", package: "NasaModels"),
                                      "DomainInterfaces"
                                  ],
                                  swiftSettings: swiftSettings),
                          .testTarget(name: "SOMDomainLayerTests",
                                      dependencies: ["SOMDomainLayer"])
                      ])
