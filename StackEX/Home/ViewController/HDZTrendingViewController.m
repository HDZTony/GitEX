//
//  HDZHomeViewController.m
//  StackEX
//
//  Created by hdz on 2019/1/18.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZTrendingViewController.h"
#import "HDZDevelopersTableViewController.h"
#import "HDZTrendingRepositoriesViewController.h"
@interface HDZTrendingViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UIViewController *currentChildVC;
@property (strong, nonatomic) HDZTrendingRepositoriesViewController  *reposVC;
@property (strong, nonatomic) HDZDevelopersTableViewController *developersVC;
@end

@implementation HDZTrendingViewController
#pragma mark Lazy method
-(HDZTrendingRepositoriesViewController *)reposVC{
    if (!_reposVC) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _reposVC = [main instantiateViewControllerWithIdentifier:@"HDZRepositoriesViewController"];
    }
    return _reposVC;
}
- (HDZDevelopersTableViewController *)developersVC{
    if (!_developersVC) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _developersVC = [main instantiateViewControllerWithIdentifier:@"HDZDevelopersTableViewController"];
    }
    return _developersVC;
}
#pragma mark View method
- (void)viewWillAppear:(BOOL)animated{
    [self.currentChildVC beginAppearanceTransition:YES animated:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [self.currentChildVC endAppearanceTransition];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.currentChildVC beginAppearanceTransition:NO animated:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [self.currentChildVC endAppearanceTransition];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}
- (void)setupView{
    //第一次显示因为developersVC没有添加进parent viewcontroller 和reposVC不是同一个parent viewcontroller报错。
    self.navigationItem.title = @"Trending";
    [self addViewController:self.developersVC];

    [self updateView];
}
#pragma mark Private method
- (void) updateView{
    if (self.segment.selectedSegmentIndex == 0) {
        [self cycleFromViewController:self.developersVC toViewController:self.reposVC];
        self.currentChildVC = self.reposVC;
//        [self removeViewController:self.developersVC];
//        [self addViewController:self.reposVC];
    }else{
        [self cycleFromViewController:self.reposVC toViewController:self.developersVC];
        self.currentChildVC = self.developersVC;
//        [self removeViewController:self.reposVC];
//        [self addViewController:self.developersVC];
    }
}

- (void)cycleFromViewController: (UIViewController*) oldVC
               toViewController: (UIViewController*) newVC {
    // Prepare the two view controllers for the change.
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    
    // Get the start frame of the new view controller and the end frame
    // for the old view controller. Both rectangles are offscreen.
    newVC.view.frame = self.view.bounds;
    CGRect endFrame = [self oldViewEndFrame];
    
    // Queue up the transition animation.
    [self transitionFromViewController: oldVC toViewController: newVC
                              duration: 0.25 options:0
                            animations:^{
                                // Animate the views to their final positions.
                                newVC.view.frame = oldVC.view.frame;
                                oldVC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                // Remove the old view controller and send the final
                                // notification to the new view controller.
                                [oldVC removeFromParentViewController];
                                [newVC didMoveToParentViewController:self];
                            }];
}

- (CGRect)oldViewEndFrame{
    CGRect rect = self.view.frame;
    rect.origin.x = rect.size.width;
    rect.origin.y = rect.size.height;
    return rect;
}

- (void)addViewController:(UIViewController *)viewController{
    [self addChildViewController:viewController];
    [self.containerView addSubview:viewController.view];
    viewController.view.frame = self.containerView.bounds;
    [viewController didMoveToParentViewController:self];
}
//- (void)removeViewController:(UIViewController *)viewController{
//    [viewController willMoveToParentViewController:nil];
//    [viewController.view removeFromSuperview];
//    [viewController removeFromParentViewController];
//}
#pragma mark Target Action
- (IBAction)segmentDidChanged:(id)sender {
    [self updateView];
}


@end
