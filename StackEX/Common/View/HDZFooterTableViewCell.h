//
//  HDZFooterTableViewCell.h
//  StackEX
//
//  Created by hdz on 2019/3/6.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class HDZReadMe;

NS_ASSUME_NONNULL_BEGIN

@interface HDZFooterTableViewCell : UITableViewCell
@property (weak, nonatomic) UITableViewController *VC;
- (void)configureFooterViewWithHtmlString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
