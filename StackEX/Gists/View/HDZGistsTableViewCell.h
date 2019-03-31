//
//  HDZGistsTableViewCell.h
//  StackEX
//
//  Created by hdz on 2019/2/20.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDZGist;
NS_ASSUME_NONNULL_BEGIN

@interface HDZGistsTableViewCell : UITableViewCell
- (void)configureCellWithModel:(HDZGist * _Nullable)model;
@end


NS_ASSUME_NONNULL_END
