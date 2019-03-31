//
//  PresentSectionViewController.m
//  DesignCode
//
//  Created by hdz on 2018/7/8.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "PresentSectionViewController.h"
#import "SectionViewController.h"

@interface PresentSectionViewController()

@end
@implementation PresentSectionViewController

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    SectionViewController *destination = [transitionContext viewControllerForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:destination.view];
    //Initial state
    NSLayoutConstraint *widthConstraint = [destination.scrollView.widthAnchor constraintEqualToConstant:304];
    NSLayoutConstraint *heightConstraint = [destination.scrollView.heightAnchor constraintEqualToConstant:248];
    NSLayoutConstraint *bottomConstraint = [destination.scrollView.bottomAnchor constraintEqualToAnchor:destination.coverView.bottomAnchor];
    [NSLayoutConstraint activateConstraints:@[widthConstraint,heightConstraint,bottomConstraint]];
    CATransform3D translate = CATransform3DMakeTranslation(self.cellFrame.origin.x, self.cellFrame.origin.y, 0.0);
    CATransform3D tranform = CATransform3DConcat(translate, self.cellTransform);
    destination.view.layer.transform = tranform;
    destination.view.layer.zPosition = 999;
    destination.scrollView.layer.cornerRadius = 14;
    destination.scrollView.layer.shadowOpacity = 0.25;
    destination.scrollView.layer.shadowOffset = CGSizeMake(0, 10);
    destination.scrollView.layer.shadowRadius = 20;
    [containerView layoutIfNeeded];
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:5 dampingRatio:0.7 animations:^{
        //Final state
        [NSLayoutConstraint deactivateConstraints:@[widthConstraint,heightConstraint,bottomConstraint]];
        destination.view.layer.transform = CATransform3DIdentity;
        destination.scrollView.layer.cornerRadius = 0;
        [containerView layoutIfNeeded];
    }];
    [animator addCompletion:^(UIViewAnimatingPosition finalPosition) {
        //completion
        [transitionContext completeTransition:YES];
    }];
    [animator startAnimation];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 5;
}

@end
