//
//  HDZUsersSearch.h
//  StackEX
//
//  Created by hdz on 2018/9/7.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HDZUsersFilter) {
    reputation,//默认从0开始
    name,
    creation,
    modified
};

@class HDZUsers;
@interface HDZUsersSearch : NSObject
@property (nonatomic,strong) NSMutableArray<HDZUsers *>* usersArray;
@property (nonatomic,assign) BOOL hasSearched;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
typedef void(^SearchComplete)(BOOL sucess);
- (void)performFilterForText:(NSString *)text category:(HDZUsersFilter )category completion:(SearchComplete)completion;
@end
