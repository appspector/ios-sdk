// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: 'AppSpector',
    platforms: [
        .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: 'AppSpector',
            targets: ['AppSpectorSDK', 'AppSpectorSDKE2E', 'AppSpectorTVSDK'])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .binaryTarget(
            name: 'AppSpectorSDK',
            url: 'https://github.com/appspector/ios-sdk/releases/download/1.3.6/AppSpectorSDK.xcframework.zip',
            checksum: '67916e1f05ef362fa64cb35c0dff1459cb38acd33e7ccea003ac18351a3b5e72'
        ),
        .binaryTarget(
            name: 'AppSpectorSDKE2E',
            url: 'https://github.com/appspector/ios-sdk/releases/download/1.3.6/AppSpectorSDKE2E.xcframework.zip',
            checksum: 'dbf35af09fa01d621e717a2239ddb615fc97265c48ff1e89bc0a95c8af3bca49'
        ),
        .binaryTarget(
            name: 'AppSpectorTVSDK',
            url: 'https://github.com/appspector/ios-sdk/releases/download/1.3.6/AppSpectorTVSDK.xcframework.zip',
            checksum: 'a4a27f7250a670c884d26f1d541e7dc2e5b51d114f6e6910a47a46d481ddd374'
        )
    ]
)
