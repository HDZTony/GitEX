//
//  HDZPublicGistsViewController.m
//  StackEX
//
//  Created by hdz on 2019/2/18.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZUserGistsViewController.h"
#import "HDZGistsTableViewCell.h"
#import "HDZGistsViewModel.h"
#import "HDZGistsRequest.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface HDZUserGistsViewController ()<HDZGistsViewModelDelegate,UITableViewDataSourcePrefetching>
@property (strong, nonatomic) HDZGistsViewModel *viewModel;

@end

@implementation HDZUserGistsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    HDZGistsRequest *request = [[HDZGistsRequest alloc] init];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLogin"];
    NSString * userPath = [NSString stringWithFormat:@"/users/%@/gists",userName];
    request.path = userPath;
    self.viewModel = [[HDZGistsViewModel alloc] initWithRequest:request delegate:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.totalCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDZGistsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HDZGistsTableViewCell" forIndexPath:indexPath];
    if ([self isLoadingCellForIndexPath:indexPath]) {
        [cell configureCellWithModel:nil];
    }else{
    [cell configureCellWithModel:self.viewModel.currentModels[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"HDZGistsTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell configureCellWithModel:self.viewModel.currentModels[indexPath.row]];
    }];
}

- (BOOL)isLoadingCellForIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row >= self.viewModel.currentModels.count;
}

#pragma mark - UITableViewDataSourcePrefetching
- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isLoadingCellForIndexPath:obj]) {
            [self.viewModel fetchGists];
            *stop = YES;
        }
    }];
}

/**
 根据模型类中新添加的数据的indexPaths和table view 中以显示的indexPaths取交集
 
 @param indexPaths 新添加模型所对应的NSIndexPaths
 @return 将要刷新的NSIndexPath Array
 */
- (NSArray<NSIndexPath *> *)visibleIndexPathsToReload:(NSArray<NSIndexPath *> *)indexPaths{
    NSArray *visibleIndexPaths = self.tableView.indexPathsForVisibleRows;
    NSMutableSet *visibleSet = [NSMutableSet setWithArray: visibleIndexPaths];
    NSSet *set = [NSSet setWithArray:indexPaths];
    [visibleSet intersectSet:set];
    NSArray *reloadIndexPaths = [visibleSet allObjects];
    return reloadIndexPaths;
}

#pragma mark - HDZGistsViewModelDelegate

/**
 根据indexPaths 刷新table view
 
 @param indexPaths 将要刷新的indexPaths
 */
-(void)fetchCompletedWidthNewIndexPaths:(NSArray *)indexPaths{
    if (!indexPaths) {
        //第一页
        [self.tableView reloadData];
    }
    NSArray *indexPathsToReload = [self visibleIndexPathsToReload:indexPaths];
    [self.tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

@end
