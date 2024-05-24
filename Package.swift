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
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.12/AppSpectorSDK.xcframework.zip",
            checksum: "d153cf89ad87e0780de68c13fbd9c93bd2b5d80e960967392d3d54f1c2252c3f"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.12/AppSpectorSDKE2E.xcframework.zip",
            checksum: "1397a0785d3d79a632193ad222e11936a8b7a97e7dc40ac715ae34fa68364dc6"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.12/AppSpectorTVSDK.xcframework.zip",
            checksum: "fdccbfc5432adadf7f93bb936264acaca7e16619e11e16912f9017145e2f177d"
        ),
        .binaryTarget(
            name: "AppSpectorOSXSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.12/AppSpectorOSXSDK.xcframework.zip",
            checksum: "474a361e7b7a5d7449799fd5566c1123bb91cf1ac07407f8001e498cca2e3a51"
        )
    ]
)
