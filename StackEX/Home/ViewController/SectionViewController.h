//
//  SectionViewController.h
//  DesignCode
//
//  Created by hdz on 2018/6/18.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *closeVisualEffectView;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *subheadVisualEffectView;
@property (strong, nonatomic) NSDictionary <NSString *,NSString *>*section;
@property (strong, nonatomic) NSArray <NSDictionary *> *sections;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end
