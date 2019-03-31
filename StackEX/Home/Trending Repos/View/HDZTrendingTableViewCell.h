//
//  HDZHomeTableViewCell.h
//  StackEX
//
//  Created by hdz on 2018/10/14.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDZTrendingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,assign) CGFloat collectionViewOffset;

/**
 <#Description#>

 @param dataSourceDelegate <#dataSourceDelegate description#>
 @param row 为collection view 赋模型时，区分不同的collection view
 */
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>)dataSourceDelegate forRow:(NSInteger)row;

- (void)configueWithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
