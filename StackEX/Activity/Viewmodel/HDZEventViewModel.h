//
//  HDZActivityViewModel.h
//  StackEX
//
//  Created by hdz on 2018/10/3.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserReceivedEventModel.h"
@class HDZRepositories;
@class HDZEventRequest;
NS_ASSUME_NONNULL_BEGIN

@protocol HDZEventViewModelDelegate<NSObject>
- (void)fetchCompletedWidthNewIndexPaths:(NSArray * _Nullable)indexPaths;
- (void)fetchFailedWithReason:(NSString *)reason;
@end

@interface HDZEventViewModel : NSObject
@property (nonatomic,strong) NSMutableArray<UserReceivedEventModel *> *events;
@property (strong, nonatomic) NSMutableArray<HDZRepositories *> *eventRepos;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) NSInteger currentCount;

- (instancetype)initWithRequest:(HDZEventRequest *)request
                       delegate:(id<HDZEventViewModelDelegate> )delegate;
- (void)fetchEvents;
- (void) fetchEventTotalCount;
- (UserReceivedEventModel *)eventAtIndexPath:(NSInteger )index;
@end

NS_ASSUME_NONNULL_END
