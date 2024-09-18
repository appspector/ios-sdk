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
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.13/AppSpectorSDK.xcframework.zip",
            checksum: "f1d832844615ad9f4987b121406cea4ea4cd846c3b20fb8161f78447d3887820"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.13/AppSpectorSDKE2E.xcframework.zip",
            checksum: "51869d0c7c5e518b5281be0be98f8c94aa182cb5dc528d385bd9b1e1249297d3"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.13/AppSpectorTVSDK.xcframework.zip",
            checksum: "d084ef890748699683436ddccb7b72ba774a91949892227a1c63600fdc33c55a"
        ),
        .binaryTarget(
            name: "AppSpectorOSXSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.13/AppSpectorOSXSDK.xcframework.zip",
            checksum: "e4c4253e3fe34e584f29bd96c34933b82a561b73e9b746ca42848724145ef27b"
        )
    ]
)
