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
            checksum: "aa991f1d4c850a3628b921399f5291960a3518f0d804cacb04b05cd3a5ec1116"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDKE2E.xcframework.zip",
            checksum: "72075756c77995b2d2db90cf7afe28841522416a563418ef458b45841a88c1cb"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorTVSDK.xcframework.zip",
            checksum: "9b5d59f8658c7aa076d0eced07f6dfc50da0a67cc87901ef43a92c69506dbe2d"
        )
    ]
)
