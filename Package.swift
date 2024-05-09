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
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.11/AppSpectorSDK.xcframework.zip",
            checksum: "78c15a6c217b67f1537565f22188a5555e43ff534b6e8c4cd83d5e4de4104462"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.11/AppSpectorSDKE2E.xcframework.zip",
            checksum: "cf070feecd41ad8febd6c01118729b069df0dd765cbd1b6db4ddd67f54a76428"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.11/AppSpectorTVSDK.xcframework.zip",
            checksum: "e3b1d949b828344fcd7a035b9a45492a607723fb0e44eb45c9968c7b5ff34405"
        ),
        .binaryTarget(
            name: "AppSpectorOSXSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.4.11/AppSpectorOSXSDK.xcframework.zip",
            checksum: "54eda74111b0b28b71c0821d4d2b579dc476c5de8e7f2daa5211cc4ae39f96bf"
        )
    ]
)
