//
//  HDZRepostories.m
//  StackEX
//
//  Created by hdz on 2018/12/12.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZRepositories.h"
#import "YYModel.h"
@implementation HDZRepositories
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"archiveURL":@"archive_url",
             @"isArchived":@"archived",
             @"isFork":@"fork",
             @"isPrivate":@"private",
             @"assigneesURL":@"assignees_url",
             @"blobsURL":@"blobs_url",
             @"blobsURL":@"branches_url",
             @"cloneURL":@"clone_url",
             @"collaboratorsURL":@"collaborators_url",
             @"commentsURL":@"comments_url",
             @"commitsURL":@"commits_url",
             @"compareURL":@"compare_url",
             @"contentsURL":@"contents_url",
             @"contributorsURL":@"contributors_url",
             @"createdAt":@"created_at",
             @"defaultBranch":@"default_branch",
             @"deploymentsURL":@"deployments_url",
             @"theDescription":@"description",
             @"downloadsURL":@"downloads_url",
             @"eventsURL":@"events_url",
             @"forksCount":@"forks_count",
             @"forksURL":@"forks_url",
             @"fullName":@"full_name",
             @"gitCommitsURL":@"git_commits_url",
             @"gitRefsURL":@"git_refs_url",
             @"gitTagsURL":@"git_tags_url",
             @"gitURL":@"git_url",
             @"hasDownloads":@"has_downloads",
             @"hasIssues":@"has_issues",
             @"hasPages":@"has_pages",
             @"hasProjects":@"has_projects",
             @"hasWiki":@"has_wiki",
             @"hooksURL":@"hooks_url",
             @"htmlURL":@"html_url",
             @"identifier":@"id",
             @"issueCommentURL":@"issue_comment_url",
             @"issueEventsURL":@"issue_events_url",
             @"issuesURL":@"issues_url",
             @"keysURL":@"keys_url",
             @"labelsURL":@"labels_url",
             @"languagesURL":@"languages_url",
             @"mergesURL":@"merges_url",
             @"milestonesURL":@"milestones_url",
             @"mirrorURL":@"mirror_url",
             @"nodeID":@"node_id",
             @"notificationsURL":@"notifications_url",
             @"openIssues":@"open_issues",
             @"openIssuesCount":@"open_issues_count",
             @"pullsURL":@"pulls_url",
             @"pushedAt":@"pushed_at",
             @"releasesURL":@"releases_url",
             @"sshURL":@"ssh_url",
             @"stargazersCount":@"stargazers_count",
             @"stargazersURL":@"stargazers_url",
             @"statusesURL":@"statuses_url",
             @"subscribersURL":@"subscribers_url",
             @"subscriptionURL":@"subscription_url",
             @"svnURL":@"svn_url",
             @"tagsURL":@"tags_url",
             @"teamsURL":@"teams_url",
             @"treesURL":@"trees_url",
             @"updatedAt":@"updated_at",
             @"watchersCount":@"watchers_count",
             };
}
@end

@implementation HDZLicense
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"nodeID":@"node_id",
             @"spdxID":@"spdx_id"
             };
}
@end


