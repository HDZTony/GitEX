//
//  HDZFilterTableViewCell.h
//  StackEX
//
//  Created by hdz on 2019/1/25.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZLanguageModel;
NS_ASSUME_NONNULL_BEGIN

@interface HDZFilterTableViewCell : UITableViewCell
- (void)configureCellWithModel:(HDZLanguageModel *)language;
@end

NS_ASSUME_NONNULL_END
