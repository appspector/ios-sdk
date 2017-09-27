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

`pod 'AppSpectorSDK', :podspec => 'https://raw.githubusercontent.com/appspector/ios-sdk/master/AppSpectorSDK.podspec'`


## Configure

### Objective-C
```objective-c
AppSpectorConfig *config = [AppSpectorConfig configWithAPIKey:YOUR_API_KEY monitorIDs:AS_ALL_MONITORS metadata:nil];
[[AppSpector spector] runWithConfig:config];
```

### Swift
```swift
let config = AppSpectorConfig(apiKey: "YOUR_API_KEY", monitorIDs: [AS_LOG_MONITOR], metadata: nil)
AppSpector().run(with: config)
```

## Feedback
Let us know what do you think or what would you like to be improved: [info@appspector.com](mailto:info@appspector.com).
