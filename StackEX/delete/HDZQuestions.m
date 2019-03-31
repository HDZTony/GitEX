//
//  HDZQuestions.m
//  StackEX
//
//  Created by hdz on 2018/9/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZQuestions.h"
@implementation HDZQuestionArray

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"items":[HDZQuestions class]};
}

@end

@implementation HDZQuestions

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"views":@"view_count",
      @"answers":@"answer_count",
      @"questionTitle":@"title",
      @"votes":@"score",
      @"questionBody":@"body_markdown"
      };
}

@end
