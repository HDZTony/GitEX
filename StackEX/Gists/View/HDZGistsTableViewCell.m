//
//  HDZGistsTableViewCell.m
//  StackEX
//
//  Created by hdz on 2019/2/20.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZGistsTableViewCell.h"
#import "HDZGists.h"
#import "HDZOwner.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HDZGistsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *avaterImageView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *gistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end
@implementation HDZGistsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.contentTextView.textContainerInset = UIEdgeInsetsZero;
    self.contentTextView.textContainer.lineFragmentPadding = 0;
}
- (void)configureCellWithModel:(HDZGist *)model{
    if (model) {
        NSError *error;
        NSURL *url =[NSURL URLWithString: model.owner.avatarURL];
        [self.avaterImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"More-Community"]];
        self.loginLabel.text = model.owner.login;
        self.gistNameLabel.text = model.files.filename;
        self.updateTimeLabel.text = model.updatedAt;
        self.contentTextView.text = [NSString stringWithContentsOfURL:        [NSURL URLWithString:model.files.rawURL]
  encoding:NSUTF8StringEncoding error:&error];
        //NSLog(@"%@",self.contentTextView.text);
    }else{
        self.loginLabel.text = @"wait";

    }
}
@end
