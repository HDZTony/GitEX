//
//  HDZRepositoriesRequest.m
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZRepositoriesRequest.h"
@interface HDZRepositoriesRequest()

@end
@implementation HDZRepositoriesRequest
- (NSString *)path{
    if (!_path) {
        NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
        _path = [NSString stringWithFormat:@"/users/%@/repos",userName];}
    return _path;
}
@end
