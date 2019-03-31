//
//  HDZGistsRequest.m
//  StackEX
//
//  Created by hdz on 2019/2/21.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZGistsRequest.h"
@interface HDZGistsRequest()
@property (nonatomic,copy) NSString *starredPath;
@property (nonatomic,copy) NSString *userPath;

@end
@implementation HDZGistsRequest
- (NSString *)starredPath{
    if (!_starredPath) {
        _starredPath = @"/gists";
    }
    return _starredPath;
}
-(NSString *)userPath{
    if (!_userPath) {
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
        _userPath = [NSString stringWithFormat:@"/users/%@/gists",userName];
    }
    return _userPath;
}
@end
