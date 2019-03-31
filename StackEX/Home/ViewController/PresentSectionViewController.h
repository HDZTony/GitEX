//
//  PresentSectionViewController.h
//  DesignCode
//
//  Created by hdz on 2018/7/8.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PresentSectionViewController : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) CGRect cellFrame;
@property (assign, nonatomic) CATransform3D cellTransform;
@end
