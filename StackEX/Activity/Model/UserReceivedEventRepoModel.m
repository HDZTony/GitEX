//
//  UserReceivedEventRepoModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventRepoModel.h"

@implementation UserReceivedEventRepoModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"userReceivedEventRepoID":@"id",
             };
}
@end
