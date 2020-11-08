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
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .binaryTarget(
            name: "AppSpectorSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDK.xcframework.zip",
            checksum: "56970b7399d754323dd6c32abbabada65dab151f289d36e0c156797493a0b04a"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDKE2E.xcframework.zip",
            checksum: '545be9fe327b390bf3fd33d1ce52653b01cd60b0ec028b842bc16a6efb152a9b'
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorTVSDK.xcframework.zip",
            checksum: "40ed09624f9e23b70da21a4f41f8c7ef5b0070b5c0e9ada31fd5bf0dfa670637"
        )
    ]
)
