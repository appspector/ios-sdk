// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AppSpector",
    platforms: [
        .iOS(.v13), .tvOS(.v13), .macOS(.v11)
    ],
    products: [
        .library(
            name: "AppSpector",
            targets: ["AppSpectorSDK", "AppSpectorSDKE2E", "AppSpectorTVSDK", "AppSpectorOSXSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "AppSpectorSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.9/AppSpectorSDK.xcframework.zip",
            checksum: "60ffd8f91bb8fe05a191a17d2494050ab9410dfa01a609b2a739d7f4110fee6a"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.9/AppSpectorSDKE2E.xcframework.zip",
            checksum: "d79761a26aac500f6c0d59afefd3050ef62a16e6e7142cbddc67ad049a5c61ad"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.9/AppSpectorTVSDK.xcframework.zip",
            checksum: "6852b5cc7deeca98ec59bf366ebc4d8df1fb2ff42a1e60dbf19d18a39de3393b"
        ),
        .binaryTarget(
            name: "AppSpectorOSXSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.9/AppSpectorOSXSDK.xcframework.zip",
            checksum: "48b851ae9b9b43c19fe339f572ff870f1ec42c56f55a09da3a23efd915899207"
        )
    ]
)
