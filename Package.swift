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
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDK.xcframework.zip",
            checksum: "e19bfc690acde770229fc9cabc301608821b887a86db2a33bdce97f8a5c7be1d"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDKE2E.xcframework.zip",
            checksum: "fd94e255888033699e430a1a119b2803bd2cf9de505d555f354f2afb5f2992dc"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorTVSDK.xcframework.zip",
            checksum: "6f593f21d3746ad0b7b6c06964f425620476b033e8830d0973b30cb1a6b21d6e"
        )
    ]
)
