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
            targets: ["AppSpectorSDK", "AppSpectorSDKE2E", "AppSpectorTVSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "AppSpectorSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.0/AppSpectorSDK.xcframework.zip",
            checksum: "fdb32272dc4a5b696c9e035f1edcd3e0150535d5f1681271e86328c0d8140cce"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.0/AppSpectorSDKE2E.xcframework.zip",
            checksum: "bb978a02890958ca7d40c1b36421bf400ebfb30c9d737becf629c6a7ec83e163"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.0/AppSpectorTVSDK.xcframework.zip",
            checksum: "89ccdb135f8384ecb3dbc5cb76c4092a7be1f535e46680ada7e71e0a8ba2eef8"
        )
    ]
)
