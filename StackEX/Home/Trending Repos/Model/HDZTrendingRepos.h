//
//  HDZTrending.h
//  StackEX
//
//  Created by hdz on 2018/12/7.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDZTrendingRepos;
@class HDZBuiltBy;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HDZTrendingRepos : NSObject
@property (nonatomic, copy)   NSString *author;
@property (nonatomic, copy)   NSArray<HDZBuiltBy *> *builtBy;
@property (nonatomic, assign) NSInteger currentPeriodStars;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, assign) NSInteger forks;
@property (nonatomic, copy)   NSString *language;
@property (nonatomic, copy)   NSString *languageColor;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, copy)   NSString *url;
@end

@interface HDZBuiltBy : NSObject
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *href;
@property (nonatomic, copy) NSString *username;
@end

NS_ASSUME_NONNULL_END
