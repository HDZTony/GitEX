//
//  HDZGitHubClient.m
//  StackEX
//
//  Created by hdz on 2018/10/3.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZWebService.h"
#import "UserReceivedEventModel.h"
#import "HDZTrendingRepos.h"
#import "HDZRepositories.h"
#import "HDZEventRequest.h"
#import "HDZRepositoriesRequest.h"
#import "HDZRequest.h"
#import "HDZTrendingRequest.h"
#import "HDZStarredRequest.h"
#import "AFNetworking.h"
#import "YYModel.h"
@interface HDZWebService()
@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) NSURL *trendingURL;
@property (nonatomic,assign) NSInteger *eventTotalCount;
@end
@implementation HDZWebService
- (NSURL *)baseURL{
    if (!_baseURL) {
        _baseURL = [NSURL URLWithString:@"https://api.github.com"];
    }
    return _baseURL;
}

- (NSURL *)trendingURL{
    if (!_trendingURL) {
        _trendingURL = [NSURL URLWithString:@"https://github-trending-api.now.sh"];
    }
    return _trendingURL;
}
-(void)fetchTrendingsWithRequest:(HDZTrendingRequest *)request
                        language:(NSString *)language
                            time:(NSString *)time
                         success:(void (^)(NSArray * _Nonnull))success
                         failure:(void (^)(NSError * _Nonnull))failure{
    NSString *path = [request.path stringByAppendingFormat:@"?language=%@&since=%@",language,time];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.trendingURL];
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *models = [NSArray yy_modelArrayWithClass:[HDZTrendingRepos class] json:responseObject];
        success(models);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
        failure(error);
    }];
}
-(void)modelsTotalCountWithRequest:(HDZRequest *)request success:(void (^)(NSInteger totalCount))success failure:(void (^)(NSError * _Nonnull))failure{
    NSString *path = [request.path stringByAppendingFormat:@"?&per_page=1"];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *responce = (NSHTTPURLResponse *)task.response;
            NSDictionary *headerFields = [responce allHeaderFields];
            NSString *link = headerFields[@"link"];
            ///<https://api.github.com/user/10328698/received_events?page=2>; rel="next", <https://api.github.com/user/10328698/received_events?page=5>; rel="last129,5 135,1"
            NSRange startRange = [link rangeOfString:@"page=" options:NSBackwardsSearch];
            NSRange endRange = [link rangeOfString:@">" options:NSBackwardsSearch];
            NSUInteger pageLength = endRange.location - startRange.location - startRange.length;
            NSUInteger pageLocation = startRange.location + startRange.length;
            NSRange pageRange = NSMakeRange(pageLocation, pageLength);
            NSInteger totalCount = [[link substringWithRange:pageRange] integerValue];
        success(totalCount);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
        failure(error);
    }];
}

- (void)fetchEventsWithRequest:(HDZEventRequest *)request
                          page:(NSInteger )page
                       success:(nonnull void (^)(NSArray * _Nonnull, NSArray * _Nonnull))success
                       failure:(nonnull void (^)(NSError * _Nonnull))failure{
    __block NSMutableArray<UserReceivedEventModel *> *models = [NSMutableArray new];
    __block NSMutableArray *repos = [NSMutableArray new];
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("mobi.hdz.event", DISPATCH_QUEUE_SERIAL);
    // 将第一个网络请求任务添加到组中
    dispatch_group_async(group,queue, ^{
        // 创建信号量
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        // 开始网络请求任务
        AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
        NSString *path = [request.path stringByAppendingFormat:@"?&page=%ld",(long)page];
        [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            models = [[NSArray yy_modelArrayWithClass:[UserReceivedEventModel class] json:responseObject] mutableCopy];
            dispatch_semaphore_signal(sema);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
            dispatch_semaphore_signal(sema);
        }];
        // 在网络请求任务成功之前，信号量等待中
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    });
    // 将第二个网络请求任务添加到组中
    dispatch_group_async(group,queue, ^{
        
        // 开始网络请求任务
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        for (int i = 0; i < models.count; i ++) {
            UserReceivedEventModel *model = models[i];
            // 创建信号量
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            [manager GET:model.repo.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HDZRepositories *repo = [HDZRepositories yy_modelWithJSON:responseObject];
                [repos insertObject:repo atIndex:i];
                dispatch_semaphore_signal(sema);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
                //https://api.github.com/repos/WilsonHu/yttps_skl_web
                //github系统问题 网址为空
                [repos insertObject:[NSNull null] atIndex:i];
                dispatch_semaphore_signal(sema);
            }];
            // 在网络请求任务成功之前，信号量等待中
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        
    });
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        success(models,repos);
    });
}

- (void)fetchRepositoriesWithRequest:(HDZRepositoriesRequest *)request success:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
    [manager GET:request.path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *models = [NSArray yy_modelArrayWithClass:[HDZRepositories class] json:responseObject];
        success(models);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
        failure(error);
    }];
}

- (void)fetchStarredWithRequest:(HDZStarredRequest *)request
                          page:(NSInteger )page
                       success:(void (^)(NSArray *models))success
                       failure:(void (^)(NSError *error))failure{
    NSString *path = [request.path stringByAppendingFormat:@"?&page=%ld",(long)page];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *models = [NSArray yy_modelArrayWithClass:[HDZRepositories class] json:responseObject];
        success(models);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
        failure(error);
    }];
}
- (void)fetchGistsWithRequest:(HDZRequest *)request
                          page:(NSInteger )page
                       success:(void (^)(NSArray *models))success
                       failure:(void (^)(NSError *error))failure{
    NSString *path = [request.path stringByAppendingFormat:@"?&page=%ld",(long)page];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@---",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *dict = (NSArray *)responseObject;
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
        failure(error);
    }];
}
@end
