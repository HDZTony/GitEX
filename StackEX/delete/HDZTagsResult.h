//
//  HDZTagsResult.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/29.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYModel.h"
@protocol YYModel;
@class HDZTagsResult;

@interface HDZTagsArray : NSObject<YYModel>
@property (nonatomic,assign) NSInteger quota_max;
@property (nonatomic,assign) NSInteger quota_remaining;
@property (nonatomic,assign) BOOL has_more;
@property (nonatomic, strong) NSArray<HDZTagsResult *>* items;
@end

@interface HDZTagsResult : NSObject<YYModel>
@property (nonatomic, copy) NSString* name;
@property (nonatomic,assign) BOOL has_synonyms;
@property (nonatomic,assign) BOOL is_moderator_only;
@property (nonatomic,assign) BOOL is_required;
@property (nonatomic, assign) NSInteger count;
@end
