//
//  HDZStarredRequest.h
//  StackEX
//
//  Created by hdz on 2018/12/16.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDZRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface HDZStarredRequest : HDZRequest
@property (copy ,readonly ,nonatomic) NSString *path;

@end

NS_ASSUME_NONNULL_END
