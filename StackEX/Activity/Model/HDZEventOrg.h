//
//  HDZEventOrg.h
//  StackEX
//
//  Created by hdz on 2019/3/16.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDZEventOrg : NSObject
@property (nonatomic,copy) NSString *avatar_url;
@property (nonatomic,copy) NSString *gravatar_id;
@property (nonatomic,copy) NSString *orgID;
@property (nonatomic,copy) NSString *login;
@property (nonatomic,copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
