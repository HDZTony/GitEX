//
//  HDZUsersViewController.m
//  StackEX
//
//  Created by hdz on 2018/9/1.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZUsersViewController.h"
#import "HDZUsers.h"
#import "HDZUsersCollectionViewCell.h"
#import "YYModel.h"
#import "HDZUsersSearch.h"
@protocol UIViewControllerTransitionCoordinator;
static  NSString *const kHDZUsersResultCell = @"HDZUsersResultCell";
@interface HDZUsersViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong)HDZUsersSearch *search;


@end

@implementation HDZUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[HDZUsersSearch alloc] init];
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
        [self.collectionView reloadData];
    }];
    [self.collectionView reloadData];
    [self.searchBar resignFirstResponder];
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HDZUsersCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kHDZUsersResultCell forIndexPath:indexPath];
    NSLog(@"indexPath.row%ld",(long)indexPath.row);
    HDZUsers *usersResult = self.search.usersArray[indexPath.row];
    [cell configureForResult:usersResult];
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.search.usersArray.count;


    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellsAcross = 2;
    CGFloat spaceBetweenCells  = 1;
    CGFloat width = (collectionView.bounds.size.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross;
    CGFloat height = 160;
    return CGSizeMake(width, height);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

@end
