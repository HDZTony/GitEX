
//
//  UserReceivedEventPayloadModel.m
//  Monkey
//
//  Created by coderyi on 15/7/22.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "UserReceivedEventPayloadModel.h"

@implementation UserReceivedEventPayloadModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"payloadDescription":@"description",

             };
}
@end
