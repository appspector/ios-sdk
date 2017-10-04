# AppSpector
With AppSpector you can remotely debug your app running in the same room or on another continent. 
You can measure app performance, view database content, logs, network requests and many more in realtime. 
This is the instrument that you've been looking for. Don't limit yourself only to simple logs. 
Debugging don't have to be painful!

## Getting Started
You can integrate AppSpector SDK linking to the framework manually or using Cocoapods.

To manually link just download AppSpectorSDK.zip, extract it and drop AppSpectorSDK.framework to your XCode project.
Then navigate to your project settings and under 'General' tab add AppSpectorSDK framework to 'Embedded Binaries' section.

To use cocoapods add this line to your podfile and run `pod install`:

```
pod 'AppSpectorSDK', :podspec => 'https://raw.githubusercontent.com/appspector/ios-sdk/master/AppSpectorSDK.podspec'
```


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
```

### Objective-C
```objective-c
NSSet *monitorIDs = [NSSet setWithObjects:AS_HTTP_MONITOR, AS_LOG_MONITOR, nil];
AppSpectorConfig *config = [AppSpectorConfig configWithAPIKey:API_KEY monitorIDs:monitorIDs];
[AppSpector runWithConfig:config];
```

### Swift
```swift
let config = AppSpectorConfig(apiKey: API_KEY, monitorIDs: [AS_HTTP_MONITOR, AS_LOG_MONITOR])
AppSpector().run(with: config)
```

## Feedback
Let us know what do you think or what would you like to be improved: [info@appspector.com](mailto:info@appspector.com).
