//
//  NSDate+HDZDate.h
//  StackEX
//
//  Created by hdz on 2019/3/15.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HDZDate)

/**
   是否为今年

 @return <#return value description#>
 */
- (BOOL)isThisYear;

- (NSDateComponents *)deltaWithNow;
@end

NS_ASSUME_NONNULL_END
