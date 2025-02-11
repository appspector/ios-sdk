[![GitHub release](https://img.shields.io/github/release/appspector/ios-sdk.svg)](https://github.com/appspector/ios-sdk)
# ![AppSpector](https://github.com/appspector/ios-sdk/raw/master/github-cover.png)

With AppSpector you can remotely debug your app running in the same room or on another continent. 
You can measure app performance, view database content, logs, network requests and many more in realtime. 
This is the instrument that you've been looking for. Don't limit yourself only to simple logs. 
Debugging don't have to be painful!


* [Installation](#installation)
* [Features](#features)
    * [Monitors](#monitors)
    * [End-to-End encryption](#end-to-end-encryption)
* [Docs](#docs)
* [Feedback](#feedback)


## Installation
Each app you want to use with AppSpector SDK you have to register on the web (https://app.appspector.com).
After adding the application navigate to app settings and copy API key.
To use AppSpector on tvOS just follow installation steps below but use AppSpectorTVSDK instead.

#### CocoaPods
<!-- integration-pods-start -->
To use CocoaPods add this line to your podfile and run `pod install`:

```
pod 'AppSpectorSDK'
```

To get SDK version with [encryption](#end-to-end-encryption) feature use `AppSpectorE2E` pod:
```
pod 'AppSpectorSDKE2E'
```

<!-- integration-pods-end -->

#### Carthage
<!-- integration-carthage-start -->
- Install [Carthage](https://github.com/Carthage/Carthage#installing-carthage)
- Add `binary "https://github.com/appspector/ios-sdk/raw/1.4.0/AppSpector.json"` to your Cartfile
- Run `carthage update`
- Drag [AppSpectorSDK.framework](https://github.com/appspector/ios-sdk/blob/master/AppSpectorSDK.framework.zip?raw=true) from the appropriate platform directory in Carthage/Build/ to the “Linked Frameworks and Libraries” section of your Xcode project’s “General” settings

To get SDK version with [encryption](#end-to-end-encryption) feature use `AppSpectorE2E` link:
https://raw.githubusercontent.com/appspector/ios-sdk/1.4.0/AppSpectorE2E.json
<!-- integration-carthage-end -->

#### SPM
AppSpector supports SPM but unfortunately not for E2E version.
Long story short: we have to wait for guys from openssl to support Apple Sillicon,
so if you need version with end-to-end encryption please refer to the main repo (https://github.com/appspector/ios-sdk) and use one of the installation methods available.


For the rest of you: to install SDK via SPM just press '+' sign in Xcode list of packages and paste repo address: 'https://github.com/appspector/ios-sdk-spm' into the search field:
![](https://github.com/appspector/ios-sdk-spm/raw/master/spm-install-1.png)
Two targets will be available: for iOS and tvOS, choose which one you need, press 'next' and you are done:
![](https://github.com/appspector/ios-sdk-spm/raw/master/spm-install-2.png)

#### Manually
<!-- integration-manual-start -->
To manually link just download [AppSpectorSDK.framework](https://github.com/appspector/ios-sdk/releases/latest/download/AppSpectorSDK.xcframework.zip) and drop AppSpectorSDK.framework to your XCode project.
Then navigate to your project settings and under 'General' tab add AppSpectorSDK framework to 'Embedded Binaries' section.

If you plan either to submit builds with AppSpector SDK to the Apple TestFlight for testing or archive them for AdHoc distribution you'll have to perform one more step: create a new “Run Script Phase” in your app’s target’s “Build Phases” and paste the following script:

```
code_sign() {
    echo "Code Signing $1 with Identity ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
    echo "/usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements $1"
    /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "$1"
}

cd "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"

for file in $(find . -type f -perm +111); do
    if ! [[ "$(file "$file")" == *"dynamically linked shared library"* ]]; then
        continue
    fi

    archs="$(lipo -info "${file}" | rev | cut -d ':' -f1 | rev)"
    stripped=""
    for arch in $archs; do
        if ! [[ "${VALID_ARCHS}" == *"$arch"* ]]; then
            lipo -remove "$arch" -output "$file" "$file" || exit 1
            stripped="$stripped $arch"
        fi
    done

    if [[ "$stripped" != "" ]]; then
        echo "Stripped $file of architectures:$stripped"
        if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
            code_sign "${file}"
        fi
    fi
done
```

This script is required as a workaround for this [Apple AppStore bug](http://www.openradar.me/radar?id=6409498411401216)


<!-- integration-manual-end -->

#### Apple TV
AppSpector is also available for tvOS, you can use any of described above methods to install it, all you need is just use `AppSpectorTVSDK` pod instead of `AppSpectorSDK` and include `AppSpectorTVSDK.framework` instead of `AppSpectorSDK.framework`.

[Join our slack to discuss setup process and features](https://slack.appspector.com)


## Features
AppSpector provides 10 monitors that tracks different activities inside your app:

### Monitors

#### CoreData monitor
Browser for CoreData stores in your app. Shows model scheme just like Xcode editor, allows to navigate data, follow relations, switching contexts and running custom fetch requests against any model / context.

![CoreData](https://storage.googleapis.com/appspector.com/images/monitor-screenshots/core-data-monitor@2x.png)

#### SQLite monitor
Provides browser for sqlite databases found in your app. Allows to track all queries, shows DB scheme and data in DB. You can issue custom SQL query on any DB and see results in browser immediately.

![SQLite monitor](https://storage.googleapis.com/appspector.com/images/monitor-screenshots/sqlite-monitor@2x.png)

#### HTTP monitor
Shows all HTTP traffic in your app. You can examine any request, see request/response headers and body.
We provide XML and JSON highliting for request/responses with formatting and folding options so even huge responses are easy to look through.

![SQLite monitor](https://storage.googleapis.com/appspector.com/images/monitor-screenshots/network-monitor@2x.png)

#### Logs monitor
Displays all logs generated by your app. We provide integration with popular logging framework [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack), all your logs written with loggers from it will be displayed with respect to their logging levels.

![Logs](https://storage.googleapis.com/appspector.com/images/monitor-screenshots/logs-monitor@2x.png)

#### Location monitor
Most of the apps are location-aware. Testing it requires changing locations yourself. In this case, location mocking is a real time saver. Just point to the location on the map and your app will change its geodata right away.

![Location](https://storage.googleapis.com/appspector.com/images/monitor-screenshots/location-monitor@2x.png)

#### Screenshot monitor
Simply captures screenshot from the device.

#### Performance monitor
Displays real-time graphs of the CPU / Memory/ Network / Disk / Battery usage.

#### Environment monitor
Gathers all of the environment variables and arguments in one place, info.plist, cli arguments and much more.

#### Notification Center monitor
Tracks all posted notifications and subscriptions. You can examine notification user info, sender/reciever objects, etc.
And naturally you can post notifications to your app from the frontend.

#### File System monitor
Provides access to the application sandbox and bundle. Using this monitor you can download, remove or upload files, create directories and just walk around your app FS.

#### Commands monitor
In short commands monitor is a remote callback collection. It allows you to register custom class as a command then trigger it from the frontend and complete or fail it from your code after performing some actions.

#### Events monitor
Events monitor allows you to send custom built event to the current session. Event will be processed as any other monitor event, displayed and stored in history.

### End-to-End encryption

AppSpector SDK collects and stores user data including logs, DB content and network traffic. All of this can contain sensetive data so to protect your privacy we offer separate build of the SDK with E2EE feature.
It allows you to encrypt all data AppSpector sends from or to your device and be sure only you can decrypt it.
To use encryption all you need is a special SDK version (see [Installation](#installation) for more details) and [AppSpector desktop application](https://appspector.com). Due to security reasons encrypted sessions are only available in desktop app.

To start using encryption you have to create a new application from the desktop app and enable E2E switch. After that please navigate to setup guide where you can as usual get your API key and public key used for encrypted sessions. Pass this keys to the `AppSpectorConfig` and you are ready to go. Please refer to the [Configure](#configure) section for more details.

## Docs
Please refer to [AppSpector documentation](https://docs.appspector.com/docs/appspector-in-a-nutshell) for detailed features description and guides.

## Feedback
Let us know what do you think or what would you like to be improved: [info@appspector.com](mailto:info@appspector.com).
