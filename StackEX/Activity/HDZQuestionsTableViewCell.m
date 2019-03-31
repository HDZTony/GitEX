//
//  HDZQuestionsTableViewCell.m
//  StackEX
//
//  Created by hdz on 2018/9/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZQuestionsTableViewCell.h"

@implementation HDZQuestionsTableViewCell

- (void)configureForResult:(HDZQuestions *)question{
    self.votes.text = question.votes;
    self.answers.text = question.answers;
    self.views.text = question.views;
    self.questionTitle.text = question.questionTitle;
    self.questionBody.text = question.questionBody;
}

@end
