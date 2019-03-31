//
//  UIColor+HDZHexColor.m
//  StackEX
//
//  Created by hdz on 2019/1/27.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "UIColor+HDZHexColor.h"

@implementation UIColor (HDZHexColor)
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end
