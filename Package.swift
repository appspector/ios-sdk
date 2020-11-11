// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AppSpector",
    platforms: [
        .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "AppSpectorSDK",
            targets: ["AppSpectorSDK"])
        .library(
            name: "AppSpectorSDKE2E",
            targets: ["AppSpectorSDKE2E"])
        .library(
            name: "AppSpectorTVSDK",
            targets: ["AppSpectorTVSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "AppSpectorSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDK.xcframework.zip",
            checksum: "f00e30664b5854712abcc2e923575fa63e5b2e415e99d0212512ce751805a1a8"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDKE2E.xcframework.zip",
            checksum: "a6a001fc6644164c53ef2f8a3c0ac6ccdc1f1355ccaeca474baeb0415076fa89"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorTVSDK.xcframework.zip",
            checksum: "8d651b97f810d5d3f932abe2d786da58ee31411df7b495541fb5572ffbecab04"
        )
    ]
)
