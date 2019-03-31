//
//  HDZUsersResult.m
//  StackEX
//
//  Created by hdz on 2018/9/7.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZUsers.h"

@implementation HDZUsersArray
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"items" : [HDZUsers class]};
}
@end

@implementation HDZUsers
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"profileImage" : @"profile_image",
             @"name" : @"display_name",
             };
}
@end
