//
//  HDZGistsViewModel.m
//  StackEX
//
//  Created by hdz on 2019/2/21.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZGistsViewModel.h"
#import "HDZGists.h"
#import "HDZWebService.h"
#import "HDZRequest.h"
#import "YYModel.h"
@interface HDZGistsViewModel()
@property (nonatomic,copy) NSMutableArray<HDZGist *> *privateModels;
@property (weak, nonatomic) id<HDZGistsViewModelDelegate> delegate;
@property (strong, nonatomic) HDZWebService *client;
@property (nonatomic,assign) BOOL isFetchInProgress;
@property (strong, nonatomic) HDZRequest *request;
@property (nonatomic,assign) NSInteger currentPage;

@end
@implementation HDZGistsViewModel
-(NSArray<HDZGist *> *)currentModels{
    return self.privateModels;
}

- (NSMutableArray<HDZGist *> *)privateModels{
    if (!_privateModels) {
        _privateModels = [[NSMutableArray alloc] init];
    }
    return _privateModels;
}
-(instancetype)initWithRequest:(HDZRequest *)request delegate:(id<HDZGistsViewModelDelegate>)delegate{
    self = [super init];
    if (self) {
        _request = request;
        _delegate = delegate;
        _client = [[HDZWebService alloc] init];
        _isFetchInProgress = NO;
        _currentPage = 1;
        [self fetchGistsTotalCount];
        [self fetchGists];
    }
    return self;
}

-(void)fetchGistsTotalCount{
    [self.client modelsTotalCountWithRequest:self.request success:^(NSInteger  totalCount) {
        self.totalCount = totalCount;
        //NSLog(@"totalCount-----%ld",totalCount);
    }
        failure:^(NSError * _Nonnull error) {
                                         
    }];
}

-(void)fetchGists{
    if (self.isFetchInProgress) {
        return;
    }
    self.isFetchInProgress = YES;
    [self.client fetchGistsWithRequest:self.request page:self.currentPage success:^(NSArray * _Nonnull models) {
        NSMutableArray *gists = [self transformDynamticJsonKey:models];
        //NSLog(@"---%@",gists);
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[HDZGist class] json:gists];
        self.currentPage += 1;
        self.isFetchInProgress = NO;
        [self.privateModels addObjectsFromArray:modelArray];
        if (self.currentPage > 2) {
            NSArray *indexPathsToReload = [self caculateIndexPathsToReloadForNewEvents:models];
            [self.delegate fetchCompletedWidthNewIndexPaths:indexPathsToReload];
        }
        else{
            //第一页
            [self.delegate fetchCompletedWidthNewIndexPaths:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        self.isFetchInProgress = NO;
        if (error) {
            NSLog(@"error:%@",NSStringFromSelector(_cmd));
        }
    }];

}



/**
 delete Wrap In dictionary


 @param array the array strcture is not equal to model data structure
 @return the array strcture is equal to model data structure
 */
- (NSMutableArray *) transformDynamticJsonKey:(NSArray *)array{
    NSMutableArray *gists = [NSMutableArray array];
    for (NSDictionary *gist in array) {
        NSMutableDictionary *mutableDict = [gist mutableCopy];
        NSDictionary *fileHead = mutableDict[@"files"];
        NSString *fileName = [[fileHead allKeys] firstObject];
        NSDictionary *content = fileHead[fileName];
        mutableDict[@"files"] = content;
        [gists addObject:mutableDict];
    }
    return gists;
}
- (NSArray<NSIndexPath *> *)caculateIndexPathsToReloadForNewEvents:(NSArray<HDZGistsViewModel *> *)newEvents {
    NSInteger startIndex = self.currentModels.count - newEvents.count;
    NSInteger endIndex = startIndex + newEvents.count;
    NSMutableArray * indexPaths = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = startIndex; i < endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end
