//
//  AppSpectorConfig.h
//  AppSpectorSDK
//
//  Created by Techery on 12/09/2017.
//  Copyright © 2017 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSpectorConfig : NSObject

@property (copy, nonatomic, readonly) NSString *apiKey;
@property (strong, nonatomic, readonly) NSSet <NSString *> *monitorIDs;


/**
 Designated initializer for config

 @param apiKey NSString key used to access application instance. You can get one on settings page after creating app on the frontend.
 @param monitorIDs NSSet <NSString *> list of monitor IDs to load. Use `AS_ALL_MONITORS` macro to enable all provided monitors.
 
 @return AppSpectorConfig
 */
+ (instancetype)configWithAPIKey:(NSString *)apiKey monitorIDs:(NSSet <NSString *> *)monitorIDs;


/**
 Convinience initializer.
 Builds config with all monitors enabled.

 @param apiKey NSString key used to access application instance. You can get one on settings page after creating app on the frontend.
 
 @return AppSpectorConfig
 */
+ (instancetype)configWithAPIKey:(NSString *)apiKey;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end
