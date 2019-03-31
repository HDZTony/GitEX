//
//  HDZQuestionsSearch.m
//  StackEX
//
//  Created by hdz on 2018/9/9.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZQuestionsSearch.h"
#import "HDZQuestions.h"
@implementation HDZQuestionsSearch
- (void)performFilterForText:(NSString *)text category:(HDZQuestionsFilter)category completion:(SearchComplete)completion{
    [self.dataTask cancel];
    [self.questionsArray removeAllObjects];
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    self.isLoading = YES;
    self.hasSearched = YES;
    NSURL *url = [self URLWithFilterText:text category:category];
    NSURLSession *session = [NSURLSession sharedSession];
    self.dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        BOOL success = NO;
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        if (error.code == -999) {
            return ;
        }else if (res.statusCode == 200){
            if (data) {
                self.questionsArray = [self parse:data];
                self.isLoading = NO;
                success = YES;
            }
        }
        if (!success) {
            self.hasSearched = NO;
            self.isLoading = NO;
        }
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            application.networkActivityIndicatorVisible = NO;
            completion(success);
        });
        
    }];
    [self.dataTask resume];
}

-(NSURL *)URLWithFilterText:(NSString *)filterText category:(HDZQuestionsFilter)category{
    filterText = @"";
    NSString *kind;
    switch (category) {
        case activity:
            kind = @"activity";
            break;
        case votes:
            kind = @"votes";
            break;
        case creation:
            kind = @"creation";
            break;
        case hot:
            kind = @"hot";
            break;
        case week:
            kind = @"week";
            break;
        case month:
            kind = @"month";
            break;
        
    }
    NSString *urlString = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions?order=desc&sort=%@&tagged=%@&site=stackoverflow",kind,filterText];
    NSString *encodedURL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodedURL];
    return url;
}

- (NSMutableArray<HDZQuestions *> *)parse:(NSData *)data{
    HDZQuestionArray * resultArray = [HDZQuestionArray yy_modelWithJSON:data];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:resultArray.items];
    return mutableArray;
}
@end
