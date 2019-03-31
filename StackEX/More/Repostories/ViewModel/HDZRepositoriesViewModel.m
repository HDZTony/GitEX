//
//  HDZRepositoriesViewModel.m
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZRepositoriesViewModel.h"
#import "HDZRepositoriesRequest.h"
#import "HDZWebService.h"
@interface HDZRepositoriesViewModel()
@property (weak, nonatomic) id<HDZRepositoriesViewModelDelegate> delegate;
@property (strong, nonatomic) HDZRepositoriesRequest *request;
@property (strong, nonatomic) HDZWebService *client;
@property (nonatomic,assign) BOOL isFetchInProgress;
@end
@implementation HDZRepositoriesViewModel
- (NSArray<HDZRepositories *> *)models{
    if (!_models) {
        [self fetchRepositories];
    }
    return _models;
}
- (instancetype)initWithDelegate:(id<HDZRepositoriesViewModelDelegate>)delegate
{
    self = [super init];
    if (self) {
        _request = [[HDZRepositoriesRequest alloc] init];
        _delegate = delegate;
        _client = [[HDZWebService alloc] init];
        _isFetchInProgress = NO;
    }
    return self;
}

- (void)fetchRepositories{
    if (self.isFetchInProgress) {
        return;
    }
    self.isFetchInProgress = YES;
    [self.client fetchRepositoriesWithRequest:self.request success:^(NSArray * _Nonnull models) {
        self.isFetchInProgress = NO;
        self.models = [NSArray arrayWithArray:models];
        [self.delegate fetchCompleted];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"failed fetchRepositories");
    }];
}
@end
