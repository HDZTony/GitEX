//
//  HDZEventTableViewCell.m
//  StackEX
//
//  Created by hdz on 2018/10/6.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZEventTableViewCell.h"
#import "UserReceivedEventModel.h"
#import "HDZRepositories.h"
#import "HDZOwner.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+HDZDate.h"
#import "DateTools.h"
#import "HDZLanguageModel.h"
#import "YYModel.h"
#import "UIColor+HDZHexColor.h"

@interface HDZEventTableViewCell()

@property (nonatomic,copy) NSArray <HDZLanguageModel *> *languageArray;

@property (weak, nonatomic) IBOutlet UIStackView *userStackView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *action;

@property (weak, nonatomic) IBOutlet UIImageView *avaterImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;

@property (weak, nonatomic) IBOutlet UILabel *repo;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIStackView *languageStackView;
@property (weak, nonatomic) IBOutlet UIView *languageRound;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
@property (weak, nonatomic) IBOutlet UILabel *star;
@property (weak, nonatomic) IBOutlet UILabel *issue;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
@property (weak, nonatomic) IBOutlet UIButton *starButton;
@end
@implementation HDZEventTableViewCell

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
    [self.userStackView setCustomSpacing:15 afterView:self.avaterImageView];
    
    [self.languageStackView setCustomSpacing:8 afterView:self.languageLabel];
    [self.languageStackView setCustomSpacing:8 afterView:self.star];
    [self.languageStackView setCustomSpacing:8 afterView:self.issue];
    
    self.languageRound.layer.cornerRadius = 6;

    self.languageLabel.textColor = HDZGrayColor;
    
    self.star.textColor = HDZGrayColor;
    
    self.issue.textColor =  HDZGrayColor;

    self.descriptionTextView.textContainerInset = UIEdgeInsetsZero;
    self.descriptionTextView.textContainer.lineFragmentPadding = 0;
    self.descriptionTextView.textColor = HDZGrayColor;

    self.repo.adjustsFontForContentSizeCategory = YES;

    [self.starButton setTitleColor:HDZGrayColor forState:UIControlStateNormal];
    //靠左对齐
    self.starButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeading;

    UIImage *image = [UIImage imageNamed:@"star"];
    self.starButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self.starButton setImage:image forState:UIControlStateNormal];

    self.updateTime.textColor = HDZGrayColor;
}

- (void)configureWithEvent:(UserReceivedEventModel *)event repository:(HDZRepositories *)repo{
    if (event) {
        NSURL *url = [NSURL URLWithString: event.actor.avatarUrl];
        [self.avaterImageView sd_setImageWithURL:url];
        self.name.text = event.actor.login;
        self.action.text = event.payload.action;
        self.repo.text = event.repo.name;
        self.eventTime.text = event.createdAt;
        
    }
    
    if ([repo isMemberOfClass:[HDZRepositories class]]){
        if (repo.theDescription) {
            self.descriptionTextView.text = repo.theDescription;
            self.descriptionTextView.hidden = NO;

        } else{
            self.descriptionTextView.hidden = YES;
        }
        if (repo.language) {
            self.languageLabel.text = repo.language;
            [self.languageArray enumerateObjectsUsingBlock:^(HDZLanguageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.name isEqualToString:repo.language] && obj.hexStringColor) {
                    self.languageRound.backgroundColor = [UIColor colorFromHexString:obj.hexStringColor];
                    *stop = YES;
                }
            }];
            self.languageRound.hidden = NO;
            self.languageLabel.hidden = NO;
        } else{
            self.languageRound.hidden = YES;
            self.languageLabel.hidden = YES;
        }
        
        
        
        if (repo.stargazersCount > 0) {
            if (repo.stargazersCount > 999) {
                double stars = repo.stargazersCount / 1000.0;
                float rounededStar = round (stars * 10.0) / 10.0;
                self.star.text = [NSString stringWithFormat:@"%.1ldk",(long)rounededStar];
            } else{
                self.star.text =  [NSString stringWithFormat:@"%ld",repo.stargazersCount];
            }
            self.star.hidden = NO;
            self.starImageView.hidden = NO;
            
        } else{
            self.star.hidden = YES;
            self.starImageView.hidden = YES;
        }
        
        if (repo.openIssuesCount > 0) {
            self.issue.text = [NSString stringWithFormat:@"%ld个问题",(long)repo.openIssuesCount];
            self.issue.hidden = NO;
        }else{
            self.issue.hidden = YES;
        }
        
        
        NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
        NSDate *date = [formatter dateFromString:repo.updatedAt];
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
    } else{
        self.descriptionTextView.text = @"null";
    }
}

@end
