//
//  HDZRepositoriesTableCell.m
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZRepositoriesTableCell.h"
#import "HDZRepositories.h"
#import "HDZLanguageModel.h"
#import "YYModel.h"
#import "UIColor+HDZHexColor.h"
#import "NSDate+HDZDate.h"
#import "DateTools.h"

@interface HDZRepositoriesTableCell()
@property (nonatomic,copy) NSArray <HDZLanguageModel *> *languageArray;
@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UITextView *descriprionTextView;
@property (weak, nonatomic) IBOutlet UIStackView *languageStackView;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UIView *languageRound;
@property (weak, nonatomic) IBOutlet UIStackView *lisenceStackView;
@property (weak, nonatomic) IBOutlet UILabel *lisenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;

@end
@implementation HDZRepositoriesTableCell

- (NSArray<HDZLanguageModel *> *)languageArray{
    if (!_languageArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"language" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _languageArray = [NSArray yy_modelArrayWithClass:[HDZLanguageModel class] json:data];
    }
    return _languageArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.languageRound.layer.cornerRadius = 6;
    
    self.languageLabel.textColor = HDZGrayColor;
    
    self.lisenceLabel.textColor = HDZGrayColor;
    
    self.descriprionTextView.textContainerInset = UIEdgeInsetsZero;
    self.descriprionTextView.textContainer.lineFragmentPadding = 0;
    self.descriprionTextView.textColor = HDZGrayColor;
    
    self.projectName.adjustsFontForContentSizeCategory = YES;
    
    self.updateTime.textColor = HDZGrayColor;
}
- (void)configureWithModel:( HDZRepositories * )repositories{
    NSString *repoString = [NSString stringWithFormat:@"%@",repositories.name];
    UIFontDescriptor *descriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleTitle3];
    UIFont *font = [UIFont fontWithDescriptor:descriptor size:0];
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:HDZBlueColor
                                 };
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:repoString attributes:attributes ];
    UIFontDescriptor *discriptorBold = [descriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    UIFont *reposFont = [UIFont fontWithDescriptor:discriptorBold size:0];
    NSRange range = NSMakeRange( 0, repositories.name.length);
    [attrString addAttribute:NSFontAttributeName value:reposFont range:range];
    self.projectName.attributedText = attrString;
    
    if (repositories.theDescription) {
        self.descriprionTextView.hidden = NO;
        self.descriprionTextView.text = repositories.theDescription;
    }else{
        self.descriprionTextView.hidden = YES;

    }

    [self.languageArray enumerateObjectsUsingBlock:^(HDZLanguageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:repositories.language] && obj.hexStringColor) {
            self.languageRound.backgroundColor = [UIColor colorFromHexString:obj.hexStringColor];
            *stop = YES;
        }
    }];
    
    if (repositories.language) {
        self.languageStackView.hidden = NO;
        self.languageLabel.text = repositories.language;
    }else{
        self.languageStackView.hidden = YES;
        
    }
    
    if (repositories.license) {
        self.lisenceStackView.hidden = NO;
        self.lisenceLabel.text = repositories.license.name;
    }else{
        self.lisenceStackView.hidden = YES;
    }
    
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSDate *date = [formatter dateFromString:repositories.updatedAt];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSString *time;
    // 判断是否为今年
    if (date.isThisYear) {
        if (date.isToday) { // 今天
            NSDateComponents *cmps = [date deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                time = [NSString stringWithFormat:@"%ld小时前更新", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                time = [NSString stringWithFormat:@"%ld分钟前更新", (long)cmps.minute];
            } else { // 1分钟内发的
                time = @"刚刚更新";
            }
        } else if (date.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm更新";
            time = [fmt stringFromDate:date];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm更新";
            time = [fmt stringFromDate:date];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd更新";
        time = [fmt stringFromDate:date];
    }
    self.updateTime.text = time;
    
    
}
@end
