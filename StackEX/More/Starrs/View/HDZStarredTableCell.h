//
//  HDZRepositoriesTableCell.h
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZRepositories;
NS_ASSUME_NONNULL_BEGIN

@interface HDZStarredTableCell : UITableViewCell
- (void)configureWithModel:(HDZRepositories * _Nullable )repositories;
@end

NS_ASSUME_NONNULL_END
