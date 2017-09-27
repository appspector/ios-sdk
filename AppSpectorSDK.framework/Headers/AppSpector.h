//
//  AppSpector.h
//  AppSpectorSDK
//
//  Created by Yevhen Sichkar on 5/18/17.
//  Copyright © 2017 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppSpectorConfig;

// Monitor IDs
static NSString * const AS_SCREENSHOT_MONITOR   = @"screenshot-monitor";
static NSString * const AS_SQLITE_MONITOR       = @"sqlite-monitor";
static NSString * const AS_HTTP_MONITOR         = @"http-monitor";
static NSString * const AS_COREDATA_MONITOR     = @"coredata-monitor";
static NSString * const AS_PERFORMANCE_MONITOR  = @"performance-monitor";
static NSString * const AS_LOG_MONITOR          = @"logger";

/**
 Macro to enable all monitors at once.
 */
#define AS_ALL_MONITORS @[AS_SCREENSHOT_MONITOR, \
                          AS_SQLITE_MONITOR,\
                          AS_HTTP_MONITOR, \
                          AS_COREDATA_MONITOR, \
                          AS_PERFORMANCE_MONITOR, \
                          AS_LOG_MONITOR]

@interface AppSpector : NSObject


/**
 Initializer for AppSPector shared instance

 @return Configured AppSpector instance ready to be started with 'runWithConfig:'
 */
+ (AppSpector *)spector;


/**
 Starts AppSpector using provided config.
 First loads and starts configured monitors then establishes session with backend using provided key.

 @param config AppSpetorConfig instance providing API key, list of monitors to load and metadata.
 */
- (void)runWithConfig:(AppSpectorConfig *)config;

@end
