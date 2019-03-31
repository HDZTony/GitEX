//
//  UserReceivedEventActorModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventActorModel.h"
#import "YYModel.h"

@implementation UserReceivedEventActorModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"actorID":@"id",
             @"gravatarId":@"gravatar_id",
             @"avatarUrl":@"avatar_url",
             @"displayLogin":@"display_login"
             };
}
@end
