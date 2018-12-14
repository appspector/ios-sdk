# ![AppSpector](https://github.com/appspector/ios-sdk/raw/master/github-cover.png)

With AppSpector you can remotely debug your app running in the same room or on another continent. 
You can measure app performance, view database content, logs, network requests and many more in realtime. 
This is the instrument that you've been looking for. Don't limit yourself only to simple logs. 
Debugging don't have to be painful!


* [Installation](#installation)
* [Features](#features)
* [Configure](#configure)
* [Custom device name](#custom-device-name)
* [Start/Stop SDK](#start-stop-sdk)
* [Filtering your data](#filtering-your-data)
* [Getting session URL](#getting-session-url)



## Installation
Each app you want to use with AppSpector SDK you have to register on the web (https://app.appspector.com).
After adding the application navigate to app settings and copy API key.
To use AppSpector on tvOS just follow installation steps below but use AppSpectorTVSDK instead.

#### CocoaPods
<!-- integration-pods-start -->
To use cocoapods add this line to your podfile and run `pod install`:

[![GitHub release](https://img.shields.io/github/release/appspector/ios-sdk.svg)](https://github.com/appspector/ios-sdk)

```
pod 'AppSpectorSDK'
```
<!-- integration-pods-end -->

#### Carthage
<!-- integration-carthage-start -->
- Install [Carthage](https://github.com/Carthage/Carthage#installing-carthage)
- Add github "appspector/ios-sdk" to your Cartfile
- Run `carthage update`
- Drag [AppSpectorSDK.framework](https://github.com/appspector/ios-sdk/blob/master/AppSpectorSDK.framework.zip?raw=true) from the appropriate platform directory in Carthage/Build/ to the “Linked Frameworks and Libraries” section of your Xcode project’s “General” settings
<!-- integration-carthage-end -->

#### Manually
<!-- integration-manual-start -->
To manually link just download [AppSpectorSDK.framework](https://github.com/appspector/ios-sdk/blob/master/AppSpectorSDK.framework.zip?raw=true) and drop AppSpectorSDK.framework to your XCode project.
Then navigate to your project settings and under 'General' tab add AppSpectorSDK framework to 'Embedded Binaries' section.

If you plan either to submit builds with AppSpector SDK to the Apple TestFlight for testing or archive them for AdHoc distribution you'll have to perform one more step: create a new “Run Script Phase” in your app’s target’s “Build Phases” and paste the following script:

```
file="AppSpectorSDK.framework/AppSpectorSDK"
archs="$(lipo -info "${file}" | rev | cut -d ':' -f1 | rev)"
stripped=""
for arch in $archs; do
    if ! [[ "${VALID_ARCHS}" == *"$arch"* ]]; then
        lipo -remove "$arch" -output "$file" "$file" || exit 1
        stripped="$stripped $arch"
    fi
done
echo "AppSpector: stripped archs: $stripped"

```

This script is required as a workaround for this [Apple AppStore bug](http://www.openradar.me/radar?id=6409498411401216)


<!-- integration-manual-end -->

#### Apple TV
AppSpector is also available for tvOS, you can use any of described above methods to install it, all you need is just use `AppSpectorTVSDK` pod instead of `AppSpectorSDK` and include `AppSpectorTVSDK.framework` instead of `AppSpectorSDK.framework`.

[Join our slack to discuss setup process and features](https://slack.appspector.com)


## Features
AppSpector provides 10 monitors that tracks different activities inside your app:

#### CoreData monitor
Browser for CoreData stores in your app. Shows model scheme just like Xcode editor, allows to navigate data, follow relations, switching contexts and running custom fetch requests against any model / context.

![CoreData](https://appspector.com/images/monitor-screenshots/core-data-monitor@2x.png)

#### SQLite monitor
Provides browser for sqlite databases found in your app. Allows to track all queries, shows DB scheme and data in DB. You can issue custom SQL query on any DB and see results in browser immediately.

![SQLite monitor](https://appspector.com/images/monitor-screenshots/sqlite-monitor@2x.png)

#### HTTP monitor
Shows all HTTP traffic in your app. You can examine any request, see request/response headers and body.
We provide XML and JSON highliting for request/responses with formatting and folding options so even huge responses are easy to look through.

![SQLite monitor](https://appspector.com/images/monitor-screenshots/network-monitor@2x.png)

#### Logs monitor
Displays all logs generated by your app. We provide integration with popular logging framework [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack), all your logs written with loggers from it will be displayed with respect to their logging levels.

![Logs](https://appspector.com/images/monitor-screenshots/logs-monitor@2x.png)

#### Location monitor
Most of the apps are location-aware. Testing it requires changing locations yourself. In this case, location mocking is a real time saver. Just point to the location on the map and your app will change its geodata right away.

![Location](https://appspector.com/images/monitor-screenshots/location-monitor@2x.png)

#### Screenshot monitor
Simply captures screenshot from the device.

#### Performance monitor
Displays real-time graphs of the CPU / Memory/ Network / Disk / Battery usage.

#### Environment monitor
Gathers all of the environment variables and arguments in one place, info.plist, cli arguments and much more.

#### Notification Center monitor
Tracks all posted notifications and subscriptions. You can examine notification user info, sender/reciever objects, etc.
And naturally you can post notifications to your app from the frontend.

## Configure
AppSpector uses modules called monitors to track different app activities and gather stats.
We provide a bunch of monitors out of the box which could be used together or in any combinations.
To start AppSpector you need to build instance of `AppSpectorConfig` and provide your API key.
You can start exact monitors with:

```configWithAPIKey:(NSString *)apiKey monitorIDs:(NSSet <NSString *> *)monitorIDs``` 

Or start all available with:

```configWithAPIKey:(NSString *)apiKey```

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
```

#### Swift
<!-- integration-swift-example-start -->
First import the framework:
```
import AppSpectorSDK
```

Starting only selected monitors:
```swift
let config = AppSpectorConfig(apiKey: "API_KEY", monitorIDs: [Monitor.http, Monitor.logs])
AppSpector.run(with: config)
```
or to start all monitors:
```
let config = AppSpectorConfig(apiKey: "API_KEY")
AppSpector.run(with: config)
```
<!-- integration-swift-example-end -->

#### Objective-C
<!-- integration-objc-example-start -->
First import the framework:
```
@import AppSpectorSDK;
```

Starting only selected monitors:
```objective-c
NSSet *monitorIDs = [NSSet setWithObjects:AS_HTTP_MONITOR, AS_LOG_MONITOR, nil];
AppSpectorConfig *config = [AppSpectorConfig configWithAPIKey:@"API_KEY" monitorIDs:monitorIDs];
[AppSpector runWithConfig:config];
```

Or all at once:
```
AppSpectorConfig *config = [AppSpectorConfig configWithAPIKey:@"API_KEY"];
[AppSpector runWithConfig:config];
```
<!-- integration-objc-example-end -->

## Custom device name

You can assign a custom name to your device to easily find needed sessions in sessions list.
To do this you have to add desired name as a value for `AS_DEVICE_NAME_KEY` key to the `config.metadata` dictionary:

#### Swift
```swift
let config = AppSpectorConfig(apiKey: "API_KEY", monitorIDs: [Monitor.http, Monitor.logs])
config.metadata = [ MetadataKey.DeviceNameKey : "Your device name" ]
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
`start` starts it again using config you provided at load. This will be a new session, all activity between `stop` and `start` calls will not be tracked.

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

## Filtering your data
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

## Getting session URL
Sometimes you may need to get URL pointing to current session from code. Say you want link crash in your crash reporter with it, write it to logs or display in your debug UI. To get this URL you have to add a session start callback:

```
[config setStartCallback:^(NSURL *sessionURL) {
    // Save url for future use...
}];
```

Some hints:
- Callback get called on a non-main thread and not guaranteed to be called on a caller thread so be carefull with not thread-safe APIs inside it
- Callback will be called again upon restart, either when you call `stop`/`start` methods or when session was dropped due to networking issues


## Feedback
Let us know what do you think or what would you like to be improved: [info@appspector.com](mailto:info@appspector.com).
