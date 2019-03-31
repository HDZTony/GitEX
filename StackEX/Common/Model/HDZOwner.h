//
//  HDZOwner.h
//  StackEX
//
//  Created by hdz on 2019/3/14.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDZOwner : NSObject
@property (nonatomic, copy)   NSString *avatarURL;
@property (nonatomic, copy)   NSString *eventsURL;
@property (nonatomic, copy)   NSString *followersURL;
@property (nonatomic, copy)   NSString *followingURL;
@property (nonatomic, copy)   NSString *gistsURL;
@property (nonatomic, copy)   NSString *gravatarID;
@property (nonatomic, copy)   NSString *htmlURL;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *login;
@property (nonatomic, copy)   NSString *nodeID;
@property (nonatomic, copy)   NSString *organizationsURL;
@property (nonatomic, copy)   NSString *receivedEventsURL;
@property (nonatomic, copy)   NSString *reposURL;
@property (nonatomic, assign) BOOL isSiteAdmin;
@property (nonatomic, copy)   NSString *starredURL;
@property (nonatomic, copy)   NSString *subscriptionsURL;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *url;

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end


NS_ASSUME_NONNULL_END
