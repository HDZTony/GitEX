//
//  HDZEventRequest.m
//  StackEX
//
//  Created by hdz on 2018/10/4.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZEventRequest.h"
@interface HDZEventRequest()
@property (nonatomic,readwrite,copy) NSString *path;
@end
@implementation HDZEventRequest
@dynamic path;
- (NSString *)path{
    if (!_path) {
        NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
        _path = [NSString stringWithFormat:@"/users/%@/received_events",login];
    }
    return _path;
}

@end
