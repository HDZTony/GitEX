//
//  RepositoryModel.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "HDZRepositoryModel.h"
#import "HDZUserModel.h"
#import "YYModel.h"
@implementation HDZRepositoryModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"userId":@"id",
             @"fullName":@"full_name",
             @"htmlUrl":@"html_url",
             @"repositoryDescription":@"description",
             @"isFork":@"fork",
             @"createdAt":@"created_at",
             @"stargazersCount":@"stargazers_count",
             @"forksCount":@"forks_count",
             @"parentOwnerName":@"login",
             @"mirrorUrl":@"mirror_url",
             };
}
@end
