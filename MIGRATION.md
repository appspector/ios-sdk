# AppSpector version 2 migration guide

We are happy to present you v2.0 of the AppSpector SDK and this guide will help you to migrate your app from using v1 to v2. This will take no more than five minutes and in most cases all you need is to change 1 line of code.


## TL;DR;
Starting the SDK v2 requires DSN instead of API key you used before. DSN is a URI containing your key and API endpoint. It looks like `https://sdk.appspector.com/{YOUR_APP_ID}/{YOUR_API_KEY}` and you can find it on the settings page of your app on the web.
When you have your DSN all you need is to change this:

Swift:
```swift
let config = AppSpectorConfig(apiKey: {API_KEY})
AppSpector.run(with: config)
```

Obj-C:
```objective-c
AppSpectorConfig *config = [AppSpectorConfig configWithAPIKey:{API_KEY}];
AppSpector runWithConfig:config];
```

To that:

Swift:
```swift
let config = AppSpectorConfig(dsnPath: {DSN})
AppSpector.run(with: config)
```

Obj-C:
```objective-c
AppSpectorConfig *config = [AppSpectorConfig configWithDSNPath:{DSN}];
AppSpector runWithConfig:config];
```

Thats all, your are ready to go.
If you want more details or your config is a bit more complex than example above - read ahead.


## SDK functional changes
Changes in API are mostly caused by functional changes in SDK v2. Most important is that now SDK is safe to run in production environment.
Why v1 was unable to do that is because realtime session was influencing app a lot, consuming battery, cpu etc. Now in v2 SDK can operate in two modes: realtime and buffered.

Realtime mode is how all sessions in v1 were working, when you can see events coming from the app on the web dashboard via opened socket. In buffered mode SDK dequeues events locally and sends them to the dashboard in batches periodically. Time interval between batches is configured from the backend depending on the number of events your app producing, current network conditions, etc. Thats how we can guarantee lowest possible impact upon your app in production.

## API changes
New session mode is reflected in a new API:

Swift:
```swift
var defaultSessionMode: SDKSessionMode
```

Obj-C:
```objective-c
@property (assign, nonatomic) SDKSessionMode defaultSessionMode;
```

It has two options: buffered and realtime, and by default buffered is used in production mode, and realtime while debugging.
By passing value to this property you set default mode for both cases production and debug.

Second new API connected with SDK session modes gives you ability to change session type at runtime.
You can call it at any time after the `run()` call to switch session type:

Swift:
```swift
AppSpector.transition(to: .buffered)
```

Obj-C:
```objective-c
[AppSpector transitionTo:SDKSessionModeBuffered];
```

Of course you may want to totally block SDK from operating in production, to do that use next config property:
`blockProductionEnvironment`.

It’s set false by default and being set to true will completely stop SDK in production so it will behave just like v1.

## Feedback
Let us know what do you think or what would you like to be improved: [info@appspector.com](mailto:info@appspector.com).
