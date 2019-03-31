//
//  UserReceivedEventModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventModel.h"
#import "YYModel.h"
@implementation UserReceivedEventModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"userReceivedEventID":@"id",
             @"userReceivedEventPublic":@"public",
             @"createdAt":@"created_at",
             };
}
@end
