// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AppSpector",
    platforms: [
        .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "AppSpector",
            targets: ["AppSpectorSDK"]),
        .library(
            name: "AppSpectorTVSDK",
            targets: ["AppSpectorTVSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "AppSpectorSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.0/AppSpectorSDK.xcframework.zip",
            checksum: "c06eb6591cb049970b97bc3e6505b872a96d1a4bca62942f017151288da1f7a0"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.0/AppSpectorTVSDK.xcframework.zip",
            checksum: "84108fe603088c6c650bff800ac8aad4bb1743de9b2b2e53d95626d7583856ba"
        )
    ]
)
