//
//  HDZOptionsTableViewController.h
//  StackEX
//
//  Created by hdz on 2019/1/21.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDZFilterTableViewController : UIViewController
- (void)setSaveBlock:(void (^)(NSString *since ,NSString * language))block;
@end

NS_ASSUME_NONNULL_END
