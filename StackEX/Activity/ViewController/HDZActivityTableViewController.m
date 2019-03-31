//
//  HDZActivityTableViewController.m
//  StackEX
//
//  Created by hdz on 2018/9/25.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZActivityTableViewController.h"
#import "HDZEventViewModel.h"
#import "HDZEventRequest.h"
#import "HDZEventTableViewCell.h"
@interface HDZActivityTableViewController ()<HDZEventViewModelDelegate,UITableViewDataSourcePrefetching>
@property (strong, nonatomic) HDZEventViewModel *viewModel;

@end

@implementation HDZActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self addHeaderRefresh];
    self.tableView.prefetchDataSource = self;
    HDZEventRequest *request = [[HDZEventRequest alloc] init];
    self.viewModel = [[HDZEventViewModel alloc] initWithRequest:request delegate:self];
    [self.viewModel fetchEventTotalCount];
    [self.viewModel fetchEvents];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.totalCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDZEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"event" forIndexPath:indexPath];

    if ([self isLoadingCellForIndexPath:indexPath]) {
        [cell configureWithEvent:nil repository:nil];
    }
    else{
        UserReceivedEventModel *event = [self.viewModel eventAtIndexPath:indexPath.row];
        HDZRepositories *repo = self.viewModel.eventRepos[indexPath.row];
        [cell configureWithEvent:event repository:repo];
    }
    return cell;
}

#pragma mark -private

- (BOOL)isLoadingCellForIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row >= self.viewModel.currentCount;
}

/**
 根据模型类中新添加的数据的indexPaths和table view 中以显示的indexPaths取交集
 
 @param indexPaths 新添加模型所对应的NSIndexPaths
 @return 将要刷新的NSIndexPath Array
 */
- (NSArray<NSIndexPath *> *)visibleIndexPathsToReload:(NSArray<NSIndexPath *> *)indexPaths{
    __block NSMutableArray *visibleIndexPaths = [NSMutableArray new];
    dispatch_async(dispatch_get_main_queue(), ^{
        visibleIndexPaths = [self.tableView.indexPathsForVisibleRows copy];
    });
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
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        });
    }
    NSArray *indexPathsToReload = [self visibleIndexPathsToReload:indexPaths];
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadRowsAtIndexPaths:indexPathsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
    });
    
}

- (void)fetchFailedWithReason:(nonnull NSString *)reason {
    
}

- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isLoadingCellForIndexPath:obj]) {
            [self.viewModel fetchEvents];
            *stop = YES;
        }
    }];
}


@end
