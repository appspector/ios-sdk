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
            url: "https://github.com/appspector/ios-sdk/releases/download/1.5/AppSpectorSDK.xcframework.zip",
            checksum: "404ebe16d688e3d2591a0e2deed2768236f0ae1764f45a8bf50fec432029dcbf"
        ),
        .binaryTarget(
            name: "AppSpectorSDKE2E",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.5/AppSpectorSDKE2E.xcframework.zip",
            checksum: "7375da02e7e52217cd6fea7fa289ab25e25e54b8ae19cff115080e1b917fb413"
        ),
        .binaryTarget(
            name: "AppSpectorTVSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.5/AppSpectorTVSDK.xcframework.zip",
            checksum: "edcc39fe5e36d4ed75687a42c29bdd2c1f482af63d963c84e143c62fe3c28366"
        ),
        .binaryTarget(
            name: "AppSpectorOSXSDK",
            url: "https://github.com/appspector/ios-sdk/releases/download/1.5/AppSpectorOSXSDK.xcframework.zip",
            checksum: "4ac732e3a0df13754b26fe4d0a79875fe1293d52a1549523b0e7c82740964075"
        )
    ]
)
