//
//  HDZHeaderTableViewCell.m
//  StackEX
//
//  Created by hdz on 2019/3/6.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZHeaderTableViewCell.h"
#import "HDZRepositories.h"
@interface HDZHeaderTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *repoName;
@property (weak, nonatomic) IBOutlet UIButton *watch;
@property (weak, nonatomic) IBOutlet UIButton *star;
@property (weak, nonatomic) IBOutlet UIButton *fork;
@property (weak, nonatomic) IBOutlet UITextView *repoDescription;
@end
@implementation HDZHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureHeaderViewWithRepositories:(HDZRepositories *)repo{
    self.repoName.text = repo.fullName;
    NSString *watchString = [NSString stringWithFormat:@"Watch %ld",repo.subscribersCount];
    NSMutableAttributedString *watchAttString = [[NSMutableAttributedString alloc] initWithString:watchString];
    NSRange range = NSMakeRange(6, watchString.length - 6);
    [watchAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0] range:range];
    [self.watch setAttributedTitle:watchAttString forState:UIControlStateNormal];
    
    NSString *starString = [NSString stringWithFormat:@"Star %ld",repo.stargazersCount];
    NSMutableAttributedString *starAttString = [[NSMutableAttributedString alloc] initWithString:starString];
    range = NSMakeRange(5, starString.length - 5);
    [starAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0] range:range];
    [self.star setAttributedTitle:starAttString forState:UIControlStateNormal];
    
    NSString *forkString = [NSString stringWithFormat:@"Fork %ld",repo.forksCount];
    NSMutableAttributedString *forkAttString = [[NSMutableAttributedString alloc] initWithString:forkString];
    range = NSMakeRange(5, forkString.length - 5);
    [forkAttString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0] range:range];
    [self.fork setAttributedTitle:forkAttString forState:UIControlStateNormal];
    self.repoDescription.text = repo.theDescription;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
