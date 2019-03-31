//
//  HDZReadMe.m
//  StackEX
//
//  Created by hdz on 2019/3/5.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZReposContent.h"
#import "YYModel.h"

@implementation HDZReposContent
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"htmlURL":@"html_url",
             @"gitURL":@"git_url",
             @"downloadURL":@"download_url",
             @"links":@"_links",
             };
}
@end

@implementation HDZLinks
@end

