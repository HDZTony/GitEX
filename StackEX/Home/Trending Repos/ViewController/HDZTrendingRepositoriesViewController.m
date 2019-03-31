//
//  ViewController.m
//  DesignCode
//
//  Created by hdz on 2018/6/18.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZTrendingRepositoriesViewController.h"
#import "HDZTrendingTableViewCell.h"
#import "HDZOwnRepositoriesTableViewController.h"
#import "HDZStarredTableViewController.h"
#import "HDZTrendingReposViewModel.h"
#import "HDZTrendingCollectionCell.h"
#import "HDZFilterTableViewController.h"
#import "HDZRepositoriesDetailController.h"
#import "HDZTrendingRepos.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "HDZRepositories.h"
@interface HDZTrendingRepositoriesViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HDZTrendingReposViewModelDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary <NSString *,NSNumber *> *storedOffsets;
@property (assign, nonatomic) CGSize itemSize;
@property (strong, nonatomic) HDZTrendingReposViewModel *trendingViewModel;


@end

@implementation HDZTrendingRepositoriesViewController
-(NSMutableDictionary<NSString *,NSNumber *> *)storedOffsets{
    if (!_storedOffsets) {
        _storedOffsets = [NSMutableDictionary new];
    }
    return _storedOffsets;
}

#pragma mark View Cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupNav];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupNav];
    
    self.itemSize = CGSizeZero;
    self.trendingViewModel = [[HDZTrendingReposViewModel alloc] initWithDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryForKey: @"trendingRepos"];
    if (dict) {
        [dict enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [self.trendingViewModel  fetchNew:NO TrendingWithLanguage:obj[0] sine:obj[1]];
        }];
    }else{
        [self.trendingViewModel fetchNew:YES TrendingWithLanguage:nil sine:nil];
    }
}
- (void)setupTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 180;
}
- (void)setupNav{
    
    self.parentViewController.navigationItem.leftBarButtonItem = [self editButtonItem];
    self.parentViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTap:)];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [self.tableView setEditing:editing animated:animated];
    [super setEditing:editing animated:animated];
}
#pragma mark Target Action
- (void)addButtonTap:(UIBarButtonItem *)item{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HDZFilterTableViewController *filterVC = [main instantiateViewControllerWithIdentifier:@"HDZFilterTableViewController"];
    [filterVC setSaveBlock:^(NSString * _Nonnull since, NSString * _Nonnull language) {
        [self.trendingViewModel fetchNew:YES TrendingWithLanguage:language sine:since];
    }];
    filterVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:filterVC animated:YES completion:nil];
    
}
#pragma mark - Table View Delegation

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        HDZTrendingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    NSArray *array = self.trendingViewModel.langDict[[@(indexPath.row) stringValue]];
    [cell configueWithArray:array];
        return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![cell isMemberOfClass:[HDZTrendingTableViewCell class]]) {
        return;
    }
    HDZTrendingTableViewCell *tableViewCell = (HDZTrendingTableViewCell *)cell;
    [tableViewCell setCollectionViewDataSourceDelegate:self forRow:indexPath.row];
    //设置collection view 上次显示的位置 ，如果没移动过，就从原点开始。
    tableViewCell.collectionViewOffset = [self.storedOffsets[[@(indexPath.row) stringValue]] floatValue] ?: -16.0;

}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![cell isMemberOfClass:[HDZTrendingTableViewCell class]]) {
        return;
    }
    HDZTrendingTableViewCell *tableViewCell = (HDZTrendingTableViewCell *)cell;
    self.storedOffsets[[@(indexPath.row) stringValue]] = @(tableViewCell.collectionViewOffset);

}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trendingViewModel.modelArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.trendingViewModel.modelArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.trendingViewModel.index-=1;
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - UICollectionViewDelegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HDZTrendingCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sectionCell" forIndexPath:indexPath];
    HDZTrendingRepos *trending = [self.trendingViewModel modelOfCollectionView:collectionView AtIndex:indexPath.item];
    [cell configureWithTrending:trending];

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView         numberOfItemsInSection:(NSInteger)section {
    return self.trendingViewModel.modelArr[collectionView.tag].count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger cellWidth = ScreenW - 24;
    NSInteger cellHeight = collectionView.frame.size.height;
    self.itemSize = CGSizeMake(cellWidth, cellHeight);
    return CGSizeMake(cellWidth, cellHeight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HDZRepositoriesDetailController *repoVC = [storyboard instantiateViewControllerWithIdentifier:@"HDZRepositoriesDetailController"];
    HDZTrendingRepos *trending = [self.trendingViewModel modelOfCollectionView:collectionView AtIndex:indexPath.item];
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@",trending.author,trending.name];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        repoVC.repo = [HDZRepositories yy_modelWithJSON:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:repoVC animated:YES];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
    }];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    //NSLog(@"velocity--%@--target-%@-contentoffset-%@",NSStringFromCGPoint(velocity),NSStringFromCGPoint(*targetContentOffset),NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat pageWidth = self.itemSize.width;
    //防止快速滑动多页
    *targetContentOffset = scrollView.contentOffset;
    CGFloat factor = 0.5;
    if (velocity.x < 0) {
        factor = -factor;
    }
    NSInteger index = round(scrollView.contentOffset.x / pageWidth + factor);
    NSInteger totalCount = self.trendingViewModel.modelArr[collectionView.tag].count;
    if (index > totalCount - 1) {
        index = totalCount - 1;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

#pragma mark - HDZTrendingReposViewModel Delegate

/**
 根据模型类中新添加的数据的indexPaths和table view 中以显示的indexPaths取交集

 @param indexPaths 新添加模型所对应的NSIndexPaths
 @return 将要刷新的NSIndexPath Array
 */
//- (NSArray<NSIndexPath *> *)visibleIndexPathsToReload:(NSArray<NSIndexPath *> *)indexPaths{
//    NSArray *visibleIndexPaths = self.tableView.indexPathsForVisibleRows;
//    NSMutableSet *visibleSet = [NSMutableSet setWithArray: visibleIndexPaths];
//    NSSet *set = [NSSet setWithArray:indexPaths];
//    [visibleSet intersectSet:set];
//    NSArray *reloadIndexPaths = [visibleSet allObjects];
//    return reloadIndexPaths;
//}

/**
 根据indexPaths 刷新table view
  @param models 模型数组
 @param indexPaths 将要刷新的indexPaths
 */
// FIXME:tableview刷新没做好
- (void)fetchCompletedWithModels:(NSArray<HDZTrendingRepos *> *)models NewIndexPaths:(NSArray <NSIndexPath *>*)indexPaths{
    
    if (!indexPaths) {
        //第一次加载
        [self.tableView reloadData];
    }
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}



@end
