//
//  HDZTableViewController.m
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZStarredTableViewController.h"
#import "HDZStarredTableCell.h"
#import "HDZStarredViewModel.h"
@interface HDZStarredTableViewController ()<HDZStarredViewModelDelegate ,UITableViewDataSourcePrefetching>
@property (strong, nonatomic) HDZStarredViewModel *viewModel;
@end

@implementation HDZStarredTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.prefetchDataSource = self;
    self.viewModel = [[HDZStarredViewModel alloc] initWithDelegate:self];
    [self.viewModel starredTotalCount];
    [self.viewModel fetchStarred];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.totalCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDZStarredTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"starred" forIndexPath:indexPath];
    
    if ([self isLoadingCellForIndexPath:indexPath]) {
        [cell configureWithModel:nil];
    }
    else{
        HDZRepositories *event = [self.viewModel modelAtIndexPath:indexPath.row];
        [cell configureWithModel:event];
    }
    return cell;
}

#pragma mark -private

- (BOOL)isLoadingCellForIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row >= self.viewModel.currentCount;
}

- (NSArray<NSIndexPath *> *)visibleIndexPathsToReload:(NSArray<NSIndexPath *> *)indexPaths{
    NSArray *visibleIndexPaths = self.tableView.indexPathsForVisibleRows;
    NSMutableSet *visibleSet = [NSMutableSet setWithArray: visibleIndexPaths];
    NSSet *set = [NSSet setWithArray:indexPaths];
    [visibleSet intersectSet:set];
    NSArray *reloadIndexPaths = [visibleSet allObjects];
    return reloadIndexPaths;
}

/**
 根据indexPaths 刷新table view
 
 @param indexPaths 将要刷新的indexPaths
 */
- (void)fetchCompletedWidthNewIndexPaths:(NSArray *)indexPaths {
    if (!indexPaths) {
        //第一页
        [self.tableView reloadData];
    }
    NSArray *indexPathsToReload = [self visibleIndexPathsToReload:indexPaths];
    [self.tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)fetchFailedWithReason:(nonnull NSString *)reason {
    
}

- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isLoadingCellForIndexPath:obj]) {
            [self.viewModel fetchStarred];
            *stop = YES;
        }
    }];
}

@end
