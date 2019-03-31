//
//  HDZRequest.h
//  StackEX
//
//  Created by hdz on 2018/12/16.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDZRequest : NSObject {
    NSString *_path;
}
@property (nonatomic ,copy) NSString *path;

@end

NS_ASSUME_NONNULL_END
