//
//  HDZEventRequest.h
//  StackEX
//
//  Created by hdz on 2018/10/4.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDZRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface HDZEventRequest : HDZRequest
@property (nonatomic,readonly,copy) NSString *path;
@end

NS_ASSUME_NONNULL_END
