//
//  HDZStarrGistsViewController.m
//  StackEX
//
//  Created by hdz on 2019/2/18.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZStarredGistsViewController.h"
#import "HDZGistsTableViewCell.h"
#import "HDZGistsViewModel.h"
@interface HDZStarredGistsViewController ()<HDZGistsViewModelDelegate>
@property (strong, nonatomic) HDZGistsViewModel *viewModel;
@end

@implementation HDZStarredGistsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.viewModel = [[HDZGistsViewModel alloc] initWithDelegate:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.currentModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HDZGistsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HDZGistsTableViewCell" forIndexPath:indexPath];
    [cell configureCellWithModel:self.viewModel.currentModels[indexPath.row]];
    return cell;
}



- (void)fetchCompletedWidthNewIndexPaths:(NSArray * _Nullable)indexPaths {
    
}


@end
