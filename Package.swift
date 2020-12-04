// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "AppSpector",
    products: [
        .library(
            name: "AppSpector",
            targets: ["AppSpectorSDK"]),
        .library(
            name: "AppSpectorTVSDK",
            targets: ["AppSpectorTVSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "AppSpectorSDK",
            url: "http://maven.appspector.com/artifactory/ios-sdk/1.4.0/AppSpectorSDK-1.4.0.xcframework.zip",
            checksum: "fdb32272dc4a5b696c9e035f1edcd3e0150535d5f1681271e86328c0d8140cce"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "http://maven.appspector.com/artifactory/ios-sdk/1.4.0/AppSpectorTVSDK-1.4.0.xcframework.zip",
            checksum: "89ccdb135f8384ecb3dbc5cb76c4092a7be1f535e46680ada7e71e0a8ba2eef8"
        )
    ]
)
