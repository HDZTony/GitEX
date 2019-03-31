//
//  HDZSearch.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/9.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HDZTagsCategory) {
    popular,//默认从0开始
    name,
    activity,
};

@class HDZTagsResult;

@interface HDZTagsSearch : NSObject
@property (nonatomic,strong) NSMutableArray<HDZTagsResult *>* tagsArray;

@property (nonatomic,assign) BOOL hasSearched;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
typedef void(^SearchComplete)(BOOL sucess);
- (void)performFilterForText:(NSString *)text category:(HDZTagsCategory )category completion:(SearchComplete)completion;
@end

