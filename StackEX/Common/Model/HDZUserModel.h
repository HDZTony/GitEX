//
//  UserModel.h
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDZUserModel : NSObject

@property(nonatomic,assign) double myID;
@property(nonatomic,assign) int rank;
@property(nonatomic,copy) NSString *categoryLocation;
@property(nonatomic,copy) NSString *categoryLanguage;
@property(nonatomic,copy) NSString *login;
@property(nonatomic,assign) int userID;
@property(nonatomic,copy) NSString *avatarURL;
@property(nonatomic,copy) NSString *gravatarID;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *htmlURL;
@property(nonatomic,copy) NSString *followersURL;
@property(nonatomic,copy) NSString *followingURL;
@property(nonatomic,copy) NSString *gistsURL;
@property(nonatomic,copy) NSString *starredURL;
@property(nonatomic,copy) NSString *subscriptionsURL;
@property(nonatomic,copy) NSString *organizationsURL;
@property(nonatomic,copy) NSString *reposURL;
@property(nonatomic,copy) NSString *eventsURL;
@property(nonatomic,copy) NSString *receivedEventsURL;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,assign) BOOL siteAdmin;
@property(nonatomic,copy) NSString *score;

//detail part
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *company;
@property(nonatomic,copy) NSString *blog;
@property(nonatomic,copy) NSString *location;
@property(nonatomic,copy) NSString *email;
@property(nonatomic,assign) int publicRepos;
@property(nonatomic,assign) int followers;
@property(nonatomic,assign) int following;
@property(nonatomic,copy) NSString *createdAt;

@end
