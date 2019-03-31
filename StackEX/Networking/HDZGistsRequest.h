//
//  HDZGistsRequest.h
//  StackEX
//
//  Created by hdz on 2019/2/21.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface HDZGistsRequest : HDZRequest
@property (nonatomic,readonly,copy) NSString *starredPath;
@property (nonatomic,readonly,copy) NSString *userPath;

@end

NS_ASSUME_NONNULL_END
