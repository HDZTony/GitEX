//
//  RepositoryModel.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDZUserModel.h"
@interface HDZRepositoryModel : NSObject
@property(nonatomic,assign) int userId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *fullName;
@property(nonatomic,copy) NSString *htmlUrl;
@property(nonatomic,copy) NSString *repositoryDescription;
@property(nonatomic,assign) BOOL isFork;
@property(nonatomic,copy) NSString *createdAt;
@property(nonatomic,copy) NSString *homepage;
@property(nonatomic,assign) int stargazersCount;
@property(nonatomic,copy) NSString *language;
@property(nonatomic,assign) int forksCount;
@property(nonatomic,strong) HDZUserModel *user;
@property(nonatomic,copy) NSString *mirrorUrl;

//detail
@property(nonatomic,copy) NSString *parentOwnerName;

@end
