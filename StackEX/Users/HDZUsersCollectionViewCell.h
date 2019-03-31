//
//  HDZUsersCollectionViewCell.h
//  StackEX
//
//  Created by hdz on 2018/9/6.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//
@class HDZUsers;
#import <UIKit/UIKit.h>

@interface HDZUsersCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
- (void)configureForResult:(HDZUsers *)result;
@end
