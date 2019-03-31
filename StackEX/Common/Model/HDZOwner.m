//
//  HDZOwner.m
//  StackEX
//
//  Created by hdz on 2019/3/14.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZOwner.h"

//@interface HDZOwner (JSONConversion)
//+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
//- (NSDictionary *)JSONDictionary;
//@end

@implementation HDZOwner

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"avatarURL":@"avatar_url",
             @"eventsURL":@"events_url",
             @"followersURL":@"followers_url",
             @"followingURL":@"following_url",
             @"gistsURL":@"gists_url",
             @"gravatarID":@"gravatar_id",
             @"htmlURL":@"html_url",
             @"identifier":@"id",
             @"nodeID":@"node_id",
             @"organizationsURL":@"organizations_url",
             @"receivedEventsURL":@"received_events_url",
             @"reposURL":@"repos_url",
             @"isSiteAdmin":@"site_admin",
             @"starredURL":@"starred_url",
             @"subscriptionsURL":@"subscriptions_url",
             };
}

+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
                                                    @"login": @"login",
                                                    @"id": @"identifier",
                                                    @"node_id": @"nodeID",
                                                    @"avatar_url": @"avatarURL",
                                                    @"gravatar_id": @"gravatarID",
                                                    @"url": @"url",
                                                    @"html_url": @"htmlURL",
                                                    @"followers_url": @"followersURL",
                                                    @"following_url": @"followingURL",
                                                    @"gists_url": @"gistsURL",
                                                    @"starred_url": @"starredURL",
                                                    @"subscriptions_url": @"subscriptionsURL",
                                                    @"organizations_url": @"organizationsURL",
                                                    @"repos_url": @"reposURL",
                                                    @"events_url": @"eventsURL",
                                                    @"received_events_url": @"receivedEventsURL",
                                                    @"type": @"type",
                                                    @"site_admin": @"isSiteAdmin",
                                                    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HDZOwner alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HDZOwner.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HDZOwner.properties.allValues] mutableCopy];
    
    for (id jsonName in HDZOwner.properties) {
        id propertyName = HDZOwner.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }
    
    [dict addEntriesFromDictionary:@{
                                     @"site_admin": _isSiteAdmin ? @YES : @NO,
                                     }];
    
    return dict;
}
@end
