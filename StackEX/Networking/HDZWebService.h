//
//  HDZGitHubClient.h
//  StackEX
//
//  Created by hdz on 2018/10/3.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HDZEventRequest;
@class HDZTrendingRequest;
@class HDZRepositoriesRequest;
@class HDZStarredRequest;
@class HDZRequest;
@class HDZGistsRequest;
@interface HDZWebService : NSObject
- (void)fetchTrendingsWithRequest:(HDZTrendingRequest *)request
                         language:(NSString *)language
                             time:(NSString *)time
                          success:(void (^)(NSArray *models))success
                          failure:(void (^)(NSError *error))failure;
- (void)modelsTotalCountWithRequest:(HDZRequest *)request
                                 success:(void (^)(NSInteger totalCount))success
                                 failure:(void (^)(NSError *error))failure;
- (void)fetchEventsWithRequest:(HDZEventRequest *)request
                          page:(NSInteger )page
                       success:(void (^)(NSArray *models ,NSArray *repos))success
                       failure:(void (^)(NSError *error))failure;
- (void)fetchRepositoriesWithRequest:(HDZRepositoriesRequest *)request
                       success:(void (^)(NSArray *models))success
                       failure:(void (^)(NSError *error))failure;

- (void)fetchStarredWithRequest:(HDZStarredRequest *)request
                          page:(NSInteger )page
                       success:(void (^)(NSArray *models))success
                       failure:(void (^)(NSError *error))failure;
- (void)fetchGistsWithRequest:(HDZRequest *)request
                         page:(NSInteger )page
                      success:(void (^)(NSArray *models))success
                      failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
