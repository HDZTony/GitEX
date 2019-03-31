//
//  HDZGistsViewController.m
//  StackEX
//
//  Created by hdz on 2019/2/18.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZGistsViewController.h"
#import "HDZUserGistsViewController.h"
#import "HDZStarredGistsViewController.h"
@interface HDZGistsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UIViewController *currentChildVC;
@property (strong, nonatomic) HDZUserGistsViewController *publicVC;
@property (strong, nonatomic) HDZStarredGistsViewController *starredVC;
@end

@implementation HDZGistsViewController

#pragma mark Lazy method
-(HDZUserGistsViewController *)publicVC{
    if (!_publicVC) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _publicVC = [main instantiateViewControllerWithIdentifier:@"HDZPublicGistsViewController"];
    }
    return _publicVC;
}
- (HDZStarredGistsViewController *)starredVC{
    if (!_starredVC) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _starredVC = [main instantiateViewControllerWithIdentifier:@"HDZStarredGistsViewController"];
    }
    return _starredVC;
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
    self.navigationItem.title = @"Gist";
    [self addViewController:self.starredVC];
    
    [self updateView];
}
#pragma mark Private method
- (void) updateView{
    if (self.segment.selectedSegmentIndex == 0) {
        [self cycleFromViewController:self.starredVC toViewController:self.publicVC];
        self.currentChildVC = self.publicVC;
    }else{
        [self cycleFromViewController:self.publicVC toViewController:self.starredVC];
        self.currentChildVC = self.starredVC;
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

#pragma mark Target Action
- (IBAction)segmentDidChanged:(id)sender {
    [self updateView];
}


@end
