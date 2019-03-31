//
//  UIColor+HDZHexColor.h
//  StackEX
//
//  Created by hdz on 2019/1/27.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HDZHexColor)
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
