//
//  HDZHomeTableViewCell.m
//  StackEX
//
//  Created by hdz on 2018/10/14.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZTrendingTableViewCell.h"
#import "HDZTrendingCollectionCell.h"
#import "HDZTrendingReposViewModel.h"
typedef NS_ENUM(NSInteger,HDZTrendingTime) {
    HDZTrendingTimeDaily,
    HDZTrendingTimeWeekly,
    HDZTrendingTimeMonthly
};
@interface HDZTrendingTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *language;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation HDZTrendingTableViewCell

- (void)setCollectionViewOffset:(CGFloat)collectionViewOffset{
    CGPoint point = CGPointMake(collectionViewOffset, 0);
    self.collectionView.contentOffset = point;
}
- (CGFloat)collectionViewOffset{
    return self.collectionView.contentOffset.x;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 12, 0, 16);
    
}




#pragma mark - Private Method

/**
 给tableview cell 语言，时间label赋值。

 @param array 数组0元素表示语言，1元素表示时间。
 */
- (void)configueWithArray:(NSArray *)array{
    if (![array.firstObject isEqualToString:@"0"]) {
        self.language.text = array[0];
        if ([array[1] isEqualToString:@"daily"]) {
            self.time.text = @"今天";
        } else if ([array[1] isEqualToString:@"weekly"]){
            self.time.text = @"本周";
        }else if ([array[1] isEqualToString:@"monthly"]){
            self.time.text = @"本月";
        }
    } else {
        self.language.text = @"所有";
        self.time.text = @"今天";
    }
    
}
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>)dataSourceDelegate forRow:(NSInteger)row{
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.tag = row;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:YES];// Stops collection view if it was scrolling.
    [self.collectionView reloadData];
}


@end
