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
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.10/AppSpectorSDK.xcframework.zip",
            checksum: "4aa22a87e15201e566c351b73e753614f1f0a9aac7dda0565a36f95bd5f18e69"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.10/AppSpectorSDKE2E.xcframework.zip",
            checksum: "d536c23f2b00af992264097099fb6aa9df34bfd5b56f86339f2cad13ea3218d3"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.10/AppSpectorTVSDK.xcframework.zip",
            checksum: "2afad367fbb43e7de8933948e4575d2a722528e75d6cfc738a7208186e05d8e0"
        ),
        .binaryTarget(
            name: "AppSpectorOSXSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.10/AppSpectorOSXSDK.xcframework.zip",
            checksum: "bbd2d7a1efa0221831996195a95b5d770b20e50faef67ce50ea721900704d196"
        )
    ]
)
