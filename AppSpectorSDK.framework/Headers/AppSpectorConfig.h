//
//  AppSpectorConfig.h
//  AppSpectorSDK
//
//  Created by Deszip on 12/09/2017.
//  Copyright © 2017 Techery. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSDictionary <NSString *, NSString *> ASMetadata;

@interface AppSpectorConfig : NSObject

@property (copy, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSArray <NSString *> *monitorIDs;
@property (strong, nonatomic) ASMetadata *metadata;

/**
 Designated initializer for config

 @param apiKey NSString key used to access application instance. You can get one on settings page after creating app on the frontend.
 @param monitorIDs NSArray <NSString *> list of monitor IDs to load. Use `AS_ALL_MONITORS` macro to enable all provided monitors.
 @param metadata ASMetadata Dictionary with string key-value pairs. Reserved for future use.
 
 @return AppSpectorConfig
 */
+ (instancetype)configWithAPIKey:(NSString *)apiKey monitorIDs:(NSArray <NSString *> *)monitorIDs metadata:(ASMetadata *)metadata;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end
