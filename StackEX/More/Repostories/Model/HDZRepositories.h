//
//  HDZRepostories.h
//  StackEX
//
//  Created by hdz on 2018/12/12.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDZRepositories;
@class HDZLicense;
@class HDZOwner;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface HDZRepositories : NSObject
@property (nonatomic, copy)           NSString *archiveURL;
@property (nonatomic, assign)         BOOL isArchived;
@property (nonatomic, copy)           NSString *assigneesURL;
@property (nonatomic, copy)           NSString *blobsURL;
@property (nonatomic, copy)           NSString *branchesURL;
@property (nonatomic, copy)           NSString *cloneURL;
@property (nonatomic, copy)           NSString *collaboratorsURL;
@property (nonatomic, copy)           NSString *commentsURL;
@property (nonatomic, copy)           NSString *commitsURL;
@property (nonatomic, copy)           NSString *compareURL;
@property (nonatomic, copy)           NSString *contentsURL;
@property (nonatomic, copy)           NSString *contributorsURL;
@property (nonatomic, copy)           NSString *createdAt;
@property (nonatomic, copy)           NSString *defaultBranch;
@property (nonatomic, copy)           NSString *deploymentsURL;
@property (nonatomic, copy)           NSString *theDescription;
@property (nonatomic, copy)           NSString *downloadsURL;
@property (nonatomic, copy)           NSString *eventsURL;
@property (nonatomic, assign)         BOOL isFork;
@property (nonatomic, assign)         NSInteger forks;
@property (nonatomic, assign)         NSInteger forksCount;
@property (nonatomic, copy)           NSString *forksURL;
@property (nonatomic, copy)           NSString *fullName;
@property (nonatomic, copy)           NSString *gitCommitsURL;
@property (nonatomic, copy)           NSString *gitRefsURL;
@property (nonatomic, copy)           NSString *gitTagsURL;
@property (nonatomic, copy)           NSString *gitURL;
@property (nonatomic, assign)         BOOL hasDownloads;
@property (nonatomic, assign)         BOOL hasIssues;
@property (nonatomic, assign)         BOOL hasPages;
@property (nonatomic, assign)         BOOL hasProjects;
@property (nonatomic, assign)         BOOL hasWiki;
@property (nonatomic, copy)           NSString *homepage;
@property (nonatomic, copy)           NSString *hooksURL;
@property (nonatomic, copy)           NSString *htmlURL;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *issueCommentURL;
@property (nonatomic, copy)           NSString *issueEventsURL;
@property (nonatomic, copy)           NSString *issuesURL;
@property (nonatomic, copy)           NSString *keysURL;
@property (nonatomic, copy)           NSString *labelsURL;
@property (nonatomic, copy)           NSString *language;
@property (nonatomic, copy)           NSString *languagesURL;
@property (nonatomic, strong)         HDZLicense *license;
@property (nonatomic, copy)           NSString *mergesURL;
@property (nonatomic, copy)           NSString *milestonesURL;
@property (nonatomic, nullable, copy) id mirrorURL;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *nodeID;
@property (nonatomic, copy)           NSString *notificationsURL;
@property (nonatomic, assign)         NSInteger openIssues;//https://api.github.com/users/HDZTony/repos
@property (nonatomic, assign)         NSInteger openIssuesCount;//https://api.github.com/users/HDZTony/repos
@property (nonatomic, strong)         HDZOwner *owner;
@property (nonatomic, assign)         BOOL isPrivate;
@property (nonatomic, copy)           NSString *pullsURL;
@property (nonatomic, copy)           NSString *pushedAt;
@property (nonatomic, copy)           NSString *releasesURL;
@property (nonatomic, assign)         NSInteger size;
@property (nonatomic, copy)           NSString *sshURL;
@property (nonatomic, assign)         NSInteger stargazersCount;
@property (nonatomic, copy)           NSString *stargazersURL;
@property (nonatomic, copy)           NSString *statusesURL;
@property (nonatomic, assign)         NSInteger networkCount;//https://api.github.com/repos/chakhsu/pinghsu
@property (nonatomic, assign)         NSInteger subscribersCount;//https://api.github.com/repos/chakhsu/pinghsu
@property (nonatomic, copy)           NSString *subscribersURL;
@property (nonatomic, copy)           NSString *subscriptionURL;
@property (nonatomic, copy)           NSString *svnURL;
@property (nonatomic, copy)           NSString *tagsURL;
@property (nonatomic, copy)           NSString *teamsURL;
@property (nonatomic, copy)           NSString *treesURL;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, assign)         NSInteger watchers;
@property (nonatomic, assign)         NSInteger watchersCount;
@end

@interface HDZLicense : NSObject
@property (nonatomic, copy)           NSString *key;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *nodeID;
@property (nonatomic, copy)           NSString *spdxID;
@property (nonatomic, nullable, copy) id url;
@end

NS_ASSUME_NONNULL_END
