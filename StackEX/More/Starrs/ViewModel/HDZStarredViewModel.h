//
//  HDZStarredViewModel.h
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDZRepositories.h"
NS_ASSUME_NONNULL_BEGIN
@protocol HDZStarredViewModelDelegate <NSObject>

- (void)fetchCompletedWidthNewIndexPaths:(NSArray * _Nullable)indexPaths;
- (void)fetchFailedWithReason:(NSString *)reason;

@end

@interface HDZStarredViewModel : NSObject
@property (nonatomic,strong) NSMutableArray<HDZRepositories *> *models;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic,assign) NSInteger currentCount;
- (instancetype)initWithDelegate:(id<HDZStarredViewModelDelegate>)delegate;
- (void)fetchStarred;
- (void)starredTotalCount;
- (HDZRepositories *)modelAtIndexPath:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
