//
//  HDZActivityViewModel.m
//  StackEX
//
//  Created by hdz on 2018/10/3.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZEventViewModel.h"
#import "HDZWebService.h"
#import "HDZEventRequest.h"
#import "UserReceivedEventModel.h"
@interface HDZEventViewModel()
@property (nonatomic,assign) BOOL isFetchInprogress;
@property (strong, nonatomic) HDZWebService *client;
@property (strong, nonatomic) HDZEventRequest *request;
@property (weak, nonatomic) id<HDZEventViewModelDelegate > delegate;

@end
@implementation HDZEventViewModel

- (NSInteger)currentCount{
    _currentCount = self.events.count;
    return _currentCount;
}

-(NSMutableArray<UserReceivedEventModel *> *)events{
    if (!_events) {
        _events = [NSMutableArray arrayWithCapacity:30];
    }
    return _events;
}
- (UserReceivedEventModel *)eventAtIndexPath:(NSInteger )index{
    return self.events[index];
    
}
- (instancetype)initWithRequest:(HDZEventRequest *)request
                       delegate:(id<HDZEventViewModelDelegate> )delegate

{
    self = [super init];
    if (self) {
        _request = request;
        _delegate = delegate;
        _isFetchInprogress = NO;
        _currentPage = 1;
        _client = [[HDZWebService alloc] init];
        _eventRepos = [[NSMutableArray alloc] initWithCapacity:30];
        
    }
    return self;
}
-(void)fetchEventTotalCount{
    [self.client modelsTotalCountWithRequest:self.request success:^(NSInteger  totalCount) {
        self.totalCount = totalCount;
        NSLog(@"totalCount-----%ld",totalCount);
    }
        failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)fetchEvents{
    if (self.isFetchInprogress) {
        return;
    }
    self.isFetchInprogress = YES;
    [self.client fetchEventsWithRequest:self.request page:self.currentPage success:^(NSArray * _Nonnull models, NSArray * _Nonnull repos) {
        self.currentPage += 1;
        self.isFetchInprogress = NO;
        [self.events addObjectsFromArray:models];
        [self.eventRepos addObjectsFromArray:repos];
        if (self.currentPage > 2) {
            NSArray *indexPathsToReload = [self caculateIndexPathsToReloadForNewEvents:models];
            [self.delegate fetchCompletedWidthNewIndexPaths:indexPathsToReload];
        }
        else{
            //第一页
            [self.delegate fetchCompletedWidthNewIndexPaths:nil];
        }
    }   failure:^(NSError * _Nonnull error) {
        self.isFetchInprogress = NO;
        if (error) {
            NSLog(@"error:%@",NSStringFromSelector(_cmd));
        }
    }];
}

- (NSArray<NSIndexPath *> *)caculateIndexPathsToReloadForNewEvents:(NSArray<UserReceivedEventModel *> *)newEvents {
    NSInteger startIndex = self.events.count - newEvents.count;
    NSInteger endIndex = startIndex + newEvents.count;
    NSMutableArray * indexPaths = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i = startIndex; i < endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}
@end
