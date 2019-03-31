//
//  HDZGistsViewModel.h
//  StackEX
//
//  Created by hdz on 2019/2/21.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HDZGist;
@class HDZRequest;
NS_ASSUME_NONNULL_BEGIN
@protocol HDZGistsViewModelDelegate <NSObject>

- (void)fetchCompletedWidthNewIndexPaths:(NSArray * _Nullable)indexPaths;

@end
@interface HDZGistsViewModel : NSObject
@property (nonatomic,copy,readonly) NSArray<HDZGist *> *currentModels;
@property (nonatomic,assign) NSInteger totalCount;

-(instancetype)initWithRequest:(HDZRequest *)request delegate:(id<HDZGistsViewModelDelegate>)delegate;
- (void)fetchGists;
@end

NS_ASSUME_NONNULL_END
