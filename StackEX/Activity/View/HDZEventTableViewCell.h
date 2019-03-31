//
//  HDZEventTableViewCell.h
//  StackEX
//
//  Created by hdz on 2018/10/6.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserReceivedEventModel;
@class HDZRepositories;
NS_ASSUME_NONNULL_BEGIN

@interface HDZEventTableViewCell : UITableViewCell


- (void)configureWithEvent:( UserReceivedEventModel * _Nullable )event
                repository:( HDZRepositories * _Nullable)repo;
@end

NS_ASSUME_NONNULL_END
