//
//  HDZStarredViewModel.m
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZStarredViewModel.h"
#import "HDZStarredRequest.h"
#import "HDZWebService.h"
@interface HDZStarredViewModel()
@property (weak, nonatomic) id<HDZStarredViewModelDelegate> delegate;
@property (strong, nonatomic) HDZStarredRequest *request;
@property (strong, nonatomic) HDZWebService *client;
@property (nonatomic,assign) BOOL isFetchInProgress;
@end
@implementation HDZStarredViewModel
- (NSArray<HDZRepositories *> *)models{
    if (!_models) {
        _models = [NSMutableArray arrayWithCapacity:30];
    }
    return _models;
}

- (NSInteger)currentCount{
    _currentCount = self.models.count;
    return _currentCount;
}

- (HDZRepositories *)modelAtIndexPath:(NSInteger )index{
    return self.models[index];
    
}

- (instancetype)initWithDelegate:(id<HDZStarredViewModelDelegate>)delegate
{
    self = [super init];
    if (self) {
        _request = [[HDZStarredRequest alloc] init];
        _delegate = delegate;
        _client = [[HDZWebService alloc] init];
        _isFetchInProgress = NO;
    }
    return self;
}

- (void)starredTotalCount{

    [self.client modelsTotalCountWithRequest:self.request success:^(NSInteger  totalCount) {
        NSLog(@"totalCount-----%ld",totalCount);
        self.totalCount = totalCount;
        
    }
        failure:^(NSError * _Nonnull error) {
            
    }];
}

- (void)fetchStarred{
    if (self.isFetchInProgress) {
            return;
        }
    self.isFetchInProgress = YES;
    [self.client fetchStarredWithRequest:self.request page:self.currentPage success:^(NSArray * _Nonnull models) {
        self.currentPage += 1;
        self.isFetchInProgress = NO;
        [self.models addObjectsFromArray:models];
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

- (NSArray<NSIndexPath *> *)caculateIndexPathsToReloadForNewEvents:(NSArray<HDZRepositories *> *)newStarred {
    NSInteger startIndex = self.models.count - newStarred.count;
    NSInteger endIndex = startIndex + newStarred.count;
    NSMutableArray * indexPaths = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = startIndex; i < endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end
