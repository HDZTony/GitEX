//
//  HDZTrendingRequest.m
//  StackEX
//
//  Created by hdz on 2018/10/24.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZTrendingRequest.h"
@interface HDZTrendingRequest()
@property (nonatomic,copy) NSString *path;

@end
@implementation HDZTrendingRequest
- (NSString *)path{
    if (!_path) {
        _path = @"/repositories";
    }
    return _path;
}
@end
