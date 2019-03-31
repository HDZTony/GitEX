//
//  HDZQuestions.h
//  StackEX
//
//  Created by hdz on 2018/9/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@class HDZQuestions;
@interface HDZQuestionArray :NSObject <YYModel>
@property (nonatomic,copy) NSArray<HDZQuestions *> *items;

@end
@interface HDZQuestions : NSObject <YYModel>
@property (strong, nonatomic) NSString *votes;
@property (strong, nonatomic) NSString *answers;
@property (strong, nonatomic) NSString *views;
@property (strong, nonatomic) NSString *questionTitle;
@property (strong, nonatomic) NSString *questionBody;
@end
