//
//  SectionCollectionViewCell.m
//  DesignCode
//
//  Created by hdz on 2018/6/24.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZTrendingCollectionCell.h"
#import "HDZTrendingRepos.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface HDZTrendingCollectionCell()
@property (weak, nonatomic) IBOutlet UIView *cornerView;
@property (weak, nonatomic) IBOutlet UILabel *repoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ownerImageView;
@property (weak, nonatomic) IBOutlet UITextView *descriprionTextView;
@property (weak, nonatomic) IBOutlet UIButton *starButton;
@property (weak, nonatomic) IBOutlet UIButton *forkButton;
@end
@implementation HDZTrendingCollectionCell
- (void)awakeFromNib{
    [super awakeFromNib];
    self.cornerView.layer.cornerRadius = 12.0f;
    self.cornerView.layer.borderWidth = 1.0f;
    self.cornerView.layer.borderColor = [UIColor clearColor].CGColor;
    self.cornerView.layer.masksToBounds = YES;
    
    self.descriprionTextView.textContainerInset = UIEdgeInsetsZero;
    self.descriprionTextView.textContainer.lineFragmentPadding = 0;
    
    self.repoLabel.adjustsFontForContentSizeCategory = YES;

    self.descriprionTextView.textColor = HDZGrayColor;
    
    
    [self.starButton setTitleColor:HDZGrayColor forState:UIControlStateNormal];
    //靠左对齐
    self.starButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeading;
    
    UIImage *image = [UIImage imageNamed:@"star"];
    self.starButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self.starButton setImage:image forState:UIControlStateNormal];
    
    [self.forkButton setTitleColor:HDZGrayColor forState:UIControlStateNormal];
    UIImage *image2 = [UIImage imageNamed:@"Fork"];
    self.forkButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self.forkButton setImage:image2 forState:UIControlStateNormal];
}
-(void)configureWithTrending:(HDZTrendingRepos *)trenging{
    NSString *repoString = [NSString stringWithFormat:@"%@/%@",trenging.author,trenging.name];
    UIFontDescriptor *descriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleTitle3];
    UIFont *font = [UIFont fontWithDescriptor:descriptor size:0];
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:HDZBlueColor
                                 };
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:repoString attributes:attributes ];
    UIFontDescriptor *discriptorBold = [descriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    UIFont *reposFont = [UIFont fontWithDescriptor:discriptorBold size:0];
    NSRange range = NSMakeRange(trenging.author.length + 1, trenging.name.length);
    [attrString addAttribute:NSFontAttributeName value:reposFont range:range];
    self.repoLabel.attributedText = attrString;
    if (trenging.builtBy.count > 0) {
        NSURL *url = [NSURL URLWithString: trenging.builtBy[0].avatar];
        [self.ownerImageView sd_setImageWithURL:url];
    }
    
    self.descriprionTextView.text = trenging.theDescription;
    
    
    
    if (trenging.stars > 999) {
        double stars = trenging.stars / 1000.0;
        float rounededStar = round (stars * 10.0) / 10.0;
        [self.starButton setTitle:[NSString stringWithFormat:@"%.01fk",rounededStar] forState:UIControlStateNormal];
    } else{
        [self.starButton setTitle:[NSString stringWithFormat:@"%ld",(long)trenging.stars] forState:UIControlStateNormal];
    }
   
    
    if (trenging.forks > 999) {
        double forks = trenging.forks / 1000.0;
        float rounededForks = round (forks * 10.0) / 10.0;
        [self.forkButton setTitle:[NSString stringWithFormat:@"%.01fk",rounededForks] forState:UIControlStateNormal];
    } else{
        [self.forkButton setTitle:[NSString stringWithFormat:@"%ld",(long)trenging.forks] forState:UIControlStateNormal];
    }
    
}
@end
