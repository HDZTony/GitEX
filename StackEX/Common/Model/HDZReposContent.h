//
//  HDZReadMe.h
//  StackEX
//
//  Created by hdz on 2019/3/5.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDZReposContent;
@class HDZLinks;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HDZReposContent : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *path;
@property (nonatomic, copy)   NSString *sha;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, copy)   NSString *htmlURL;
@property (nonatomic, copy)   NSString *gitURL;
@property (nonatomic, copy)   NSString *downloadURL;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *content;
@property (nonatomic, copy)   NSString *encoding;
@property (nonatomic, strong) HDZLinks *links;
@end

@interface HDZLinks : NSObject
@property (nonatomic, copy) NSString *self;
@property (nonatomic, copy) NSString *git;
@property (nonatomic, copy) NSString *html;
@end

NS_ASSUME_NONNULL_END
