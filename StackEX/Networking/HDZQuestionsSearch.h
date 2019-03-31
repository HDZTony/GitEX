//
//  HDZQuestionsSearch.h
//  StackEX
//
//  Created by hdz on 2018/9/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,HDZQuestionsFilter) {
    activity,
    votes,
    hot,
    creation,
    week,
    month
};
@class HDZQuestions;
@interface HDZQuestionsSearch : NSObject
@property (nonatomic,strong) NSMutableArray<HDZQuestions *>* questionsArray;
@property (nonatomic,assign) BOOL hasSearched;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
typedef void(^SearchComplete)(BOOL sucess);
- (void)performFilterForText:(NSString *)text category:(HDZQuestionsFilter )category completion:(SearchComplete)completion;
@end
