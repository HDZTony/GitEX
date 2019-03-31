//
//  HDZHeaderTableViewCell.h
//  StackEX
//
//  Created by hdz on 2019/3/6.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZRepositories;
NS_ASSUME_NONNULL_BEGIN

@interface HDZHeaderTableViewCell : UITableViewCell
- (void)configureHeaderViewWithRepositories:(HDZRepositories *)repo;

@end

NS_ASSUME_NONNULL_END
