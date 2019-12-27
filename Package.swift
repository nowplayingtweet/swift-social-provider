// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-social-provider",
    products: [
        // Products define the executables and librries produced by a package, and make them visible to other packages.
        .library(name: "SocialProvider", targets: ["SocialProtocol"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "SocialProtocol", dependencies: []),
        .testTarget(name: "SocialProviderTests", dependencies: ["SocialProtocol"]),
        .target(name: "HTTPExtension", dependencies: ["AsyncHTTPClient"]),
        .testTarget(name: "HTTPExtensionTests", dependencies: ["HTTPExtension"]),
    ]
)
