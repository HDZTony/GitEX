//
//  UserModel.m
//  GitHubYi
//
//  Created by coderyi on 15/3/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "HDZUserModel.h"
#import "YYModel.h"
@implementation HDZUserModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"userID" : @"id",
             @"avatarURL" : @"avatar_url",
             @"gravatarID" : @"gravatar_id",
             @"htmlURL" : @"html_url",
             @"followersUrl" : @"followers_url",
             @"followingURL":@"following_url",
             @"gistsURL":@"gists_url",
             @"starredURL":@"starred_url",
             @"subscriptionsURL":@"subscriptions_url",
             @"organizationsURL":@"organizations_url",
             @"reposURL":@"repos_url",
             @"eventsURL":@"events_url",
             @"receivedEventsURL":@"received_events_url",
             @"siteAdmin":@"site_admin",
             @"publicRepos":@"public_repos",
             @"createdAt":@"created_at"
             };
}

@end
