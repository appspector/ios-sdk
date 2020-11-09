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
            checksum: "899fdfeb95e2bd1a515784b843b0b1ad5d0f2c351bac608ac0be0797b1678aea"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorSDKE2E.xcframework.zip",
            checksum: "08dbd42c3f93589241c38977e57fe2f37649e431cd6b1d84537a3d8206994cb3"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.3.7/AppSpectorTVSDK.xcframework.zip",
            checksum: "5a5527a945d74392ef48bab377dbc348da116c90d4874952892bef3fda1572b0"
        )
    ]
)
