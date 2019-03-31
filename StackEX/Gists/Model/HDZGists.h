//
//  HDZGist.h
//  StackEX
//
//  Created by hdz on 2019/2/20.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//
#import <Foundation/Foundation.h>

@class HDZGist;
@class HDZFiles;
@class HDZFirstMd;
@class HDZOwner;

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<HDZGist *> HDZGists;
#pragma mark - Top-level marshaling functions

HDZGists *_Nullable HDZGistsFromData(NSData *data, NSError **error);
HDZGists *_Nullable HDZGistsFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData   *_Nullable HDZGistsToData(HDZGists *gists, NSError **error);
NSString *_Nullable HDZGistsToJSON(HDZGists *gists, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface HDZGist : NSObject
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, copy)           NSString *forksURL;
@property (nonatomic, copy)           NSString *commitsURL;
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSString *nodeID;
@property (nonatomic, copy)           NSString *gitPullURL;
@property (nonatomic, copy)           NSString *gitPushURL;
@property (nonatomic, copy)           NSString *htmlURL;
@property (nonatomic, strong)         HDZFiles *files;
@property (nonatomic, assign)         BOOL isPublic;
@property (nonatomic, copy)           NSString *createdAt;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, copy)           NSString *theDescription;
@property (nonatomic, assign)         NSInteger comments;
@property (nonatomic, nullable, copy) id user;
@property (nonatomic, copy)           NSString *commentsURL;
@property (nonatomic, strong)         HDZOwner *owner;
@property (nonatomic, assign)         BOOL isTruncated;
@end

@interface HDZFiles : NSObject
@property (nonatomic, copy)   NSString *filename;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSString *language;
@property (nonatomic, copy)   NSString *rawURL;
@property (nonatomic, assign) NSInteger size;
@end



NS_ASSUME_NONNULL_END
