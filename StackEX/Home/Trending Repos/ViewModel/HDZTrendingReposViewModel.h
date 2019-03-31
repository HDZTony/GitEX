//
//  HDZTrendingViewModel.h
//  StackEX
//
//  Created by hdz on 2018/10/24.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HDZTrendingRequest;
@class HDZTrendingRepos;
@class HDZLanguageModel;
NS_ASSUME_NONNULL_BEGIN

@protocol HDZTrendingReposViewModelDelegate<NSObject>
- (void)fetchCompletedWithModels:(NSArray<HDZTrendingRepos *> *)models  NewIndexPaths:(NSArray * _Nullable)indexPaths;
@end

@interface HDZTrendingReposViewModel : NSObject

@property (strong, atomic,readonly) NSMutableArray <NSArray * > *modelArr;
@property (atomic,copy,readonly) NSMutableDictionary <NSString *,NSArray * >* langDict;
//记录collectionView 数据的位置；
@property (atomic,assign) NSUInteger index;
- (instancetype)initWithDelegate:(id<HDZTrendingReposViewModelDelegate> )delegate;
- (void)fetchNew:(BOOL )first TrendingWithLanguage:( NSString * _Nullable  )lanaguage sine:( NSString * _Nullable )time;
- (HDZTrendingRepos *)modelOfCollectionView:(UICollectionView *)collectionView AtIndex:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
