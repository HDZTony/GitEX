//
//  HDZQuestionsTableViewCell.h
//  StackEX
//
//  Created by hdz on 2018/9/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDZQuestions.h"
@interface HDZQuestionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *votes;
@property (weak, nonatomic) IBOutlet UILabel *answers;
@property (weak, nonatomic) IBOutlet UILabel *views;
@property (weak, nonatomic) IBOutlet UILabel *questionTitle;
@property (weak, nonatomic) IBOutlet UILabel *questionBody;
- (void) configureForResult:(HDZQuestions *)question;
@end
