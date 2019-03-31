//
//  HDZRepositoriesTableController.m
//  StackEX
//
//  Created by hdz on 2019/3/1.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZRepositoriesDetailController.h"
#import "HDZRepositoriesDictionaryController.h"
#import "HDZFooterTableViewCell.h"
#import "HDZHeaderTableViewCell.h"
#import "HDZRepositories.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "AFNetworking.h"
#import "HDZOwner.h"
#import "HDZReposContent.h"
#import "YYModel.h"
@interface HDZRepositoriesDetailController ()
@property (copy, nonatomic) NSString *htmlString;
@property (nonatomic,copy) NSArray<NSArray *> *cellData;

@end

@implementation HDZRepositoriesDetailController
-(void)setHtmlString:(NSString *)htmlString{
    if (htmlString == _htmlString) return;
    _htmlString = htmlString;
    [self updateFooterUI];
}

- (NSArray<NSArray *> *)cellData{
    
    if (!_cellData) {
        NSString *lisence = self.repo.license ? self.repo.license.name : @"NO lisence"; 
        _cellData = @[@[@"Code",@"Issues",@"Pull requests"
                        ],
                      @[@"commits",@"branches",@"releases",@"contributors",lisence]
                      ];
    }
    return _cellData;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadReadMe];

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellData.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == self.cellData.count + 1){
        return 1;
    }else{
        return self.cellData[section - 1].count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *lisence = [NSIndexPath indexPathForRow:4 inSection:1];
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        HDZHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header" forIndexPath:indexPath];
        [cell configureHeaderViewWithRepositories:self.repo];
        return cell;
    } else if (indexPath.section == self.cellData.count + 1){
        HDZFooterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footer" forIndexPath:indexPath];
        cell.VC = self;
        //[cell configureFooterViewWithReadMe:self.readMe];
        return cell;
    }else if (indexPath == lisence) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"basic" forIndexPath:indexPath];
    } else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"rightDetail" forIndexPath:indexPath];
    }
    cell.textLabel.text = self.cellData[indexPath.section - 1][indexPath.row];
    if (indexPath.section == 1) {
        float MB = self.repo.size / 1024.0 / 1024 ;
        NSString *issues = self.repo.hasIssues ?    [NSString stringWithFormat:@"%ld", (long)self.repo.openIssuesCount ]  : @"";
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%f MB",MB ];
                break;
            case 1:
                cell.detailTextLabel.text = issues;
                break;
            case 2:
                cell.detailTextLabel.text = @"pull reguest 没做";
                break;
        }
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = @"commit 没做";
                break;
            case 1:
                cell.detailTextLabel.text = @"branch 没做";
                break;
            case 2:
                cell.detailTextLabel.text = @"release 没做";
                break;
            case 3:
                cell.detailTextLabel.text = @"contributor 没做";
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"content" sender:indexPath];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"content"]) {
        HDZRepositoriesDictionaryController *contentVC = segue.destinationViewController;
        [self loadCode:contentVC];
        
        
    }
}

#pragma mark - Navigation

/**
 不用AFNetworking因为不能修改首部 Accept 
 */
- (void)loadReadMe{
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/readme",self.repo.owner.login,self.repo.name];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request addValue:@"application/vnd.github.v3.html" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        self.htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
    [dataTask resume];
    
}

- (void)loadCode:(HDZRepositoriesDictionaryController *)VC{
    NSString *url = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/contents",self.repo.owner.login,self.repo.name];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            VC.contents = [NSArray yy_modelArrayWithClass:[HDZReposContent class] json:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
        }];
}

- (void)updateFooterUI{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.cellData.count + 1];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        HDZFooterTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell configureFooterViewWithHtmlString:self.htmlString];
        [self.tableView reloadData];
    });
    
    //[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
@end
