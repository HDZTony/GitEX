//
//  HDZSearch.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/9.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZTagsSearch.h"
#import "HDZTagsResult.h"
#import <UIKit/UIKit.h>
@interface HDZTagsSearch()
@end
@implementation HDZTagsSearch

- (void)performFilterForText:(NSString *)text category:(HDZTagsCategory )category completion:(SearchComplete)completion{
        [self.dataTask cancel];
        UIApplication *application = [UIApplication sharedApplication];
        application.networkActivityIndicatorVisible = YES;
        self.isLoading = YES;
        self.hasSearched = YES;
        [self.tagsArray removeAllObjects];
        NSURL *url = [self URLWithFilterText:text category:category];
        NSURLSession *session = [NSURLSession sharedSession];
        self.dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            BOOL success = NO;
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            if (error.code == -999) {
                return ;
            }else if (res.statusCode == 200){
                if (data) {
                    self.tagsArray = [self parse:data];
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

-(NSURL *)URLWithFilterText:(NSString *)filterText category:(HDZTagsCategory)category{
    NSString *kind;
    switch (category) {
        case popular:
            kind = @"popular";
            break;
        case name:
            kind = @"name";
            break;
        case activity:
            kind = @"activity";
            break;
    }
    NSString *urlString = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/tags?order=desc&sort=%@&inname=%@&site=stackoverflow",kind,filterText];
    NSString *encodedURL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodedURL];
    return url;
}
- (NSMutableArray<HDZTagsResult *> *)parse:(NSData *)data{
    HDZTagsArray * resultArray = [HDZTagsArray yy_modelWithJSON:data];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:resultArray.items];
    return mutableArray;
}
@end
