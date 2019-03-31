//
//  HDZUsersResult.h
//  StackEX
//
//  Created by hdz on 2018/9/7.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
@class HDZUsers;
@protocol YYModel;
@interface HDZUsersArray:NSObject<YYModel>
@property (nonatomic,copy) NSArray<HDZUsers *> *items;


@end
@interface HDZUsers : NSObject<YYModel>
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *profileImage;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *reputation;
/** 暂时不做
@property (strong, nonatomic) NSString *tags;
*/
@end
