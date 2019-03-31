//
//  HDZFilterTableViewCell.m
//  StackEX
//
//  Created by hdz on 2019/1/25.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZFilterTableViewCell.h"
#import "HDZLanguageModel.h"
#import "UIColor+HDZHexColor.h"
@interface HDZFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation HDZFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureCellWithModel:(HDZLanguageModel *)language{
    self.nameLabel.text = language.name;
    if (language.hexStringColor) {
        self.colorView.backgroundColor = [UIColor colorFromHexString:language.hexStringColor];
    }else{
        self.colorView.backgroundColor = HDZRandomColor;
    }
    
}

@end
