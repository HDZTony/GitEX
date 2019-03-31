//
//  HDZUsersSearch.m
//  StackEX
//
//  Created by hdz on 2018/9/7.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZUsersSearch.h"
#import "HDZUsers.h"
@implementation HDZUsersSearch
-(void)performFilterForText:(NSString *)text category:(HDZUsersFilter)category completion:(SearchComplete)completion{
    [self.dataTask cancel];
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    self.isLoading = YES;
    self.hasSearched = YES;
    [self.usersArray removeAllObjects];
    NSURL *url = [self URLWithFilterText:text category:category];
    NSURLSession *session = [NSURLSession sharedSession];
    self.dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        BOOL success = NO;
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        if (error.code == -999) {
            return ;
        }else if (res.statusCode == 200){
            if (data) {
                self.usersArray = [self parse:data];
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
-(NSURL *)URLWithFilterText:(NSString *)filterText category:(HDZUsersFilter)category{
    filterText = @"";
    NSString *kind;
    switch (category) {
        case reputation:
            kind = @"reputation";
            break;
        case name:
            kind = @"name";
            break;
        case creation:
            kind = @"creation";
            break;
        case modified:
            kind = @"modified";
            break;
    }
    NSString *urlString = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/users?order=desc&sort=%@&inname=%@&site=stackoverflow",kind,filterText];
    NSString *encodedURL = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodedURL];
    return url;
}
- (NSMutableArray<HDZUsers *> *)parse:(NSData *)data{
    HDZUsersArray * resultArray = [HDZUsersArray yy_modelWithJSON:data];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:resultArray.items];
    return mutableArray;
}
@end
