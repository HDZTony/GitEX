//
//  HDZStarredRequest.m
//  StackEX
//
//  Created by hdz on 2018/12/16.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZStarredRequest.h"
#import "HDZRequest.h"
@interface HDZStarredRequest()
@end
@implementation HDZStarredRequest
@dynamic path;

- (NSString *)path{
    if (!_path) {
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
        _path = [NSString stringWithFormat:@"/users/%@/starred",userName];}
    return _path;
}
@end
