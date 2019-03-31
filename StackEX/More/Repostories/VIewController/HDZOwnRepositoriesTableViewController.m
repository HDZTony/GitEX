//
//  HDZTableViewController.m
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZOwnRepositoriesTableViewController.h"
#import "HDZRepositoriesTableCell.h"
#import "HDZRepositoriesViewModel.h"
@interface HDZOwnRepositoriesTableViewController ()<HDZRepositoriesViewModelDelegate>
@property (strong, nonatomic) HDZRepositoriesViewModel *viewModel;
@end

@implementation HDZOwnRepositoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[HDZRepositoriesViewModel alloc] initWithDelegate:self];
    [self.viewModel fetchRepositories];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.models.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDZRepositoriesTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repos" forIndexPath:indexPath];
    HDZRepositories *model = self.viewModel.models[indexPath.row];
    [cell configureWithModel:model];
    return cell;
}

- (void)fetchCompleted {
    [self.tableView reloadData];
}


@end
