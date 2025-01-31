[![GitHub release](https://img.shields.io/github/release/appspector/ios-sdk.svg)](https://github.com/appspector/ios-sdk)
# ![AppSpector](https://github.com/appspector/ios-sdk/raw/master/github-cover.png)

With AppSpector you can remotely debug your app running in the same room or on another continent. 
You can measure app performance, view database content, logs, network requests and many more in realtime. 
This is the instrument that you've been looking for. Don't limit yourself only to simple logs. 
Debugging don't have to be painful!


* [Installation](#installation)
* [Configuration](#configure)
* [Sessions](#sessions)
* [SDK in production mode](#sdk-in-production-mode)
* [Monitors](#monitors)
* [Features](#features)
    * [End-to-End encryption](#end-to-end-encryption)
    * [Filtering your data](#filtering-your-data)
    * [Getting session URL](#getting-session-url)
    * [Custom device name](#custom-device-name)
    * [Start/Stop SDK](#startstop-sdk)
    * [Session mode switch](#session-mode-switch)
* [Migration from v1 SDK to v2](#migration-from-v1-sdk-to-v2)
* [Feedback](#feedback)


## Installation
Each app you want to use with AppSpector SDK you have to register on the web (https://app.appspector.com).
After adding the application navigate to app settings and copy the DSN URL.
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

#### Manually
<!-- integration-manual-start -->
To manually link just download [AppSpectorSDK.framework](https://github.com/appspector/ios-sdk/blob/master/AppSpectorSDK.framework.zip?raw=true) and drop AppSpectorSDK.framework to your XCode project.
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

## Configure
AppSpector uses modules called monitors to track different app activities and gather stats.
We provide a bunch of monitors out of the box which could be used together or in any combinations.
AppSpector SDK uses DSN (data source name) URL for configuration. It's a valid URL containing your app credentials, ID and access token.
You can get it on the frontend in a 'Setup guide' section. To provide DSN to the SDK use next API:

#### Objective-C
```objective-c
[AppSpectorConfig configWithDSNPath:[YOUR_APP_DSN]];
```

#### Swift
```swift
AppSpectorConfig(dsnPath: [YOUR_APP_DSN])
```

Available monitors:

```
AS_SCREENSHOT_MONITOR
AS_SQLITE_MONITOR
AS_HTTP_MONITOR
AS_COREDATA_MONITOR
AS_PERFORMANCE_MONITOR
AS_LOG_MONITOR
AS_LOCATION_MONITOR
AS_ENVIRONMENT_MONITOR
AS_NOTIFICATION_MONITOR
AS_ANALYTICS_MONITOR
AS_DEFAULTS_MONITOR
AS_COMMANDS_MONITOR
AS_CUSTOMEVENTS_MONITOR
AS_FS_MONITOR
```

#### Swift
<!-- integration-swift-example-start -->
First import the framework:
```
import AppSpectorSDK
```

Start selected monitors only
```swift
let config = AppSpectorConfig(dsnPath: [YOUR_APP_DSN], monitorIDs: [Monitor.http, Monitor.logs])
```
or start all monitors
```swift
let config = AppSpectorConfig(dsnPath: [YOUR_APP_DSN])
AppSpector.run(with: config)
```
<!-- integration-swift-example-end -->

#### Objective-C
<!-- integration-objc-example-start -->
First import the framework:
```
@import AppSpectorSDK;
```

Start selected monitors only
```objective-c
NSSet *monitorIDs = [NSSet setWithObjects:AS_HTTP_MONITOR, AS_LOG_MONITOR, nil];
AppSpectorConfig *config = [AppSpectorConfig configWithDSNPath:[YOUR_APP_DSN] monitorIDs:monitorIDs];
[AppSpector runWithConfig:config];
```

or start all monitors
```
AppSpectorConfig *config = [AppSpectorConfig configWithDSNPath:[YOUR_APP_DSN]];
[AppSpector runWithConfig:config];
```

To start encrypted session you need to use SDK version with E2EE enabled (see [Installation](#installation) for details) and provide your app public key alongside with API key:

#### Swift
```swift
let config = AppSpectorConfig(apiKey: "API_KEY", publicKey: "PUB_KEY")
AppSpector.run(with: config)
```

#### Objective-C
```
AppSpectorConfig *config = [AppSpectorConfig configWithAPIKey:@"API_KEY" publicKey:@"PUB_KEY"];
[AppSpector runWithConfig:config];
```

<!-- integration-objc-example-end -->

#### Plist based config

AppSpector provides an alternative method to configure the SDK by adding a property list (plist) file to your project with the necessary configuration information.

The file should be named AppSpector.plist, be a valid plist file, and placed in the root of your app bundle. 
If the SDK finds this configuration file, it will start automatically when the app loads and ignore subsequent calls to the `start` method.
You can find an example plist file [here](https://slack.appspector.com](https://github.com/appspector/ios-sdk/blob/readme-update/AppSpector.plist). Simply copy it to your project and modify the keys as needed.
The plist configuration contains a list of monitors to be started. If you want to prevent a specific monitor from running, remove it from the list, and it will not be initialized. 

You can start a monitor later from the dashboard.
Refer to the [documentation](https://docs.appspector.com/docs/appspector-in-a-nutshell) for more details on running monitors on demand.

## Sessions
Session is a concept representing period from the start os the AppSpector SDK till it stop or host app termination.
Sessions are stored on a backend with all related metadadta and received events. You can examine session contents both in realtime while session is running and later whan session has already finished. Sessions are persisted for a certain period of time which depends on your pricing plan.


## SDK in production mode
One of the most valuable AppSpector features is a special mode for running SDK in production environment.
From version 2 SDK has two ways to run sessions: live and buffered. Main difference is that in buffered mode SDK does not open persistent socket connection to the backend. This saves energy and provides minimal impact on the end user experience while using the app. In most cases user will not even notice AppSpector is here.

Buffered sessions looks same as live ones on the frontend with one major difference: two way interaction is not available for them. You cant influence SDK in that mode, this means you can't navigate CoreData store, take screenshots etc. Sessions in buffered mode looks mostly like offline sessions, you can see data in most monitors but can't interact with them.


## Monitors
AppSpector provides 10 monitors that tracks different activities inside your app:

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
Displays all logs generated by your app. Logs monitor gets data from two main sources, one is stdout/stderr streams of your app and second is logs generated via AppSpector SDK built in logger. To use SDK logger there is a class `ASAppSpectorLogger` with a `logMessage(_ message: String, tag: String, level: ASLogEventLevel)` class method. Message and tag will be displayed along with other log messages in log monitor in web dashboard. Log level could be used to filter logs.

Log monitor has API to provide available log sources, you can use following property in `AppSpectorConfig` class: `logMonitorSources: [LogSource]`.
Available values for `LogSource` are `system` thar represents stdout/stderr streams and `user` for SDK logger.
By default both sources are enabled. You can change sources anytime before the SDK `run()` call.

We also provide integration with popular logging framework [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack), all your logs written with loggers from it will be displayed with respect to their logging levels.

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

## Features

### End-to-End encryption

AppSpector SDK collects and stores user data including logs, DB content and network traffic. All of this can contain sensetive data so to protect your privacy we offer separate build of the SDK with E2EE feature.
It allows you to encrypt all data AppSpector sends from or to your device and be sure only you can decrypt it.
To use encryption all you need is a special SDK version (see [Installation](#installation) for more details) and [AppSpector desktop application](https://appapector.com). Due to security reasons encrypted sessions are only available in desktop app.

To start using encryption you have to create a new application from the desktop app and enable E2E switch. After that please navigate to setup guide where you can as usual get your API key and public key used for encrypted sessions. Pass this keys to the `AppSpectorConfig` and you are ready to go. Please refer to the [Configure](#configure) section for more details.

### Filtering your data
Sometimes you may want to adjust or completely skip some pieces of data AppSpector gather. We have a special feature called Sanitizing for this, for now it's available only for HTTP and logs monitors, more coming.
For these two monitors you can provide a filter which allows to modify or block events before AppSpector sends them to the backend. Filter is a callback you assign to a `AppSpectorConfig` property `httpSanitizer` for HTTP monitor or `logSanitizer` for logs monitor. Filter callback gets event as its argument and should return it.

Some examples. Let's say we want to skip our auth token from requests headers:
```
[config.httpSanitizer setFilter:^ASHTTPEvent *(ASHTTPEvent *event) {
    if ([event.request.allHTTPHeaderFields.allKeys containsObject:@"YOUR-AUTH-HEADER"]) {
        [event.request setValue:@"redacted" forHTTPHeaderField:@"YOUR-AUTH-HEADER"];
    }

    return event;
}];
```

Or we want to raise log level to `warning` for all messages containing word 'token':
```
[config.logSanitizer setFilter:^ASLogMonitorEvent *(ASLogMonitorEvent *event) {
    if ([event.message rangeOfString:@"token"].location != NSNotFound) {
        event.level = ASLogEventLevelWarn;
    }

    return event;
}];
```

See events headers for more info.

### Getting session URL
Sometimes you may need to get URL pointing to current session from code. Say you want link crash in your crash reporter with it, write it to logs or display in your debug UI. To get this URL you have to add a session start callback:

```
[config setStartCallback:^(NSURL *sessionURL) {
    // Save url for future use...
}];
```

Some hints:
- Callback get called on a non-main thread and not guaranteed to be called on a caller thread so be carefull with not thread-safe APIs inside it
- Callback will be called again upon restart, either when you call `stop`/`start` methods or when session was dropped due to networking issues


## Custom device name

You can assign a custom name to your device to easily find needed sessions in sessions list.
To do this you have to add desired name as a value for `AS_DEVICE_NAME_KEY` key to the `config.metadata` dictionary:

#### Swift
```swift
let config = AppSpectorConfig(apiKey: "API_KEY", monitorIDs: [Monitor.http, Monitor.logs])
config.metadata = [ DeviceNameKey : "Your device name" ]
```

#### Objective-C
```objective-c
AppSpectorConfig *config = [AppSpectorConfig configWithAPIKey:@"API_KEY" monitorIDs:monitorIDs];
config.metadata = @{ AS_DEVICE_NAME_KEY : @"Your device name" };
```


## Start/Stop SDK
AppSpector start is two step process.
When you link with AppSpector framework it starts to collect data immediately after load. When you call `startWithConfig` method - AppSpector opens a connection to the backend and from that point you can see your session on the frontend.

You can manually control AppSpector state by calling `start` and `stop` methods.
`stop` tells AppSpector to disable all data collection and close current session.
`start` starts it again using config you provided at load. This will be a new session, all activity between `stop` and `start` calls will not be tracked. To check current SDK state you can use `+ (BOOL)isRunning` method.

#### Swift
<!-- start-stop-swift-example-start -->
```swift
AppSpector.stop()
AppSpector.start()
```
<!-- start-stop-swift-example-end -->

#### Objective-C
<!-- start-stop-objc-example-start -->
```objective-c
[AppSpector stop];
[AppSpector start];
```
<!-- start-stop-objc-example-end -->

## Session mode switch

Starting v2 SDK provides to types of sessions: Live and Buffered. SDK provides API for switch from one to another:
#### Objective-C
```objective-c
[AppSpector transitionTo:SDKSessionModeBuffered];
```
#### Swift
```swift
AppSpector.transition(to: .buffered)
```

Also `AppSpetorConfig` now has an option to set default session mode to start with. This mode will be used by default when you start the SDK:
#### Objective-C
```objective-c
AppSpectorConfig *config = [AppSpectorConfig configWithDSNPath:@"https://sdk.appspector.com/[YOUR_APP_ID]/[YOUR_APP_TOKEN]"];
config.defaultSessionMode = SDKSessionModeBuffered;
```
#### Swift
```swift
let config = AppSpectorConfig(dsnPath: "https://sdk.appspector.com/[YOUR_APP_ID]/[YOUR_APP_TOKEN]")
config.defaultSessionMode = .buffered
```

## Migration from v1 SDK to v2
We know it's always hard to maintain breaking changes in third party SDKs. Thats why we prepared a special migration guide for you to move from AppSpector v1 to v2 without any issues and in 5 minutes: [AppSpector migration guide](https://github.com/appspector/ios-sdk/blob/readme-update/MIGRATION.md)

## Feedback
Let us know what do you think or what would you like to be improved: [info@appspector.com](mailto:info@appspector.com).
