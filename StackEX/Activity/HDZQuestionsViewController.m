//
//  HDZUsersViewController.m
//  StackEX
//
//  Created by hdz on 2018/9/1.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZQuestionsViewController.h"
#import "HDZQuestionsTableViewCell.h"
#import "YYModel.h"
#import "HDZQuestionsSearch.h"
@protocol UIViewControllerTransitionCoordinator;
static  NSString *const kHDZQuestionsResultCell = @"HDZQuestionsResultCell";
@interface HDZQuestionsViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong)HDZQuestionsSearch *search;


@end

@implementation HDZQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[HDZQuestionsSearch alloc] init];
    [self performSearch];
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    [self performSearch];
}
// MARK:- Private Methods
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}

- (void)showNetworkError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Whoops..." message:@"There was an error accessing the iTunes Store. Please try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self performSearch];
}

- (void)performSearch{
    [self.search performFilterForText:self.searchBar.text category:self.segmentedControl.selectedSegmentIndex completion:^(BOOL sucess) {
        if (!sucess) {
            [self showNetworkError];
        }
        [self.tableView reloadData];
    }];
    [self.tableView reloadData];
    [self.searchBar resignFirstResponder];
}




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HDZQuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHDZQuestionsResultCell forIndexPath:indexPath];
    HDZQuestions *question = self.search.questionsArray[indexPath.row];
    [cell configureForResult:question];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.search.questionsArray.count;
}



@end
