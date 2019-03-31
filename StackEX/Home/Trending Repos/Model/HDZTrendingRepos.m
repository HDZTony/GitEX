//
//  HDZTrending.m
//  StackEX
//
//  Created by hdz on 2018/12/7.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZTrendingRepos.h"
#import "YYModel.h"
@implementation HDZTrendingRepos
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"theDescription":@"description"
             };
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"builtBy" : [HDZBuiltBy class]};
}
@end

@implementation HDZBuiltBy
@end
