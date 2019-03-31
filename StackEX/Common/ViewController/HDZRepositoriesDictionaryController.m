//
//  HDZRepositoriesContentController.m
//  StackEX
//
//  Created by hdz on 2019/3/9.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZRepositoriesDictionaryController.h"
#import "HDZRepositoriesContentViewController.h"
#import "HDZReposContent.h"
#import "AFNetworking.h"
#import "YYModel.h"
static NSString * const segueIdentifierOfDictionary = @"contentdictionary";
static NSString * const segueIdentifierOfFile = @"contentfile";

@interface HDZRepositoriesDictionaryController ()

@end

@implementation HDZRepositoriesDictionaryController

- (void)setContents:(NSArray *)contents{
    if (_contents == contents) return;
    _contents = contents;
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"content" forIndexPath:indexPath];
    HDZReposContent *file = self.contents[indexPath.row];
    cell.textLabel.text = file.name;
    if ([file.type isEqualToString:@"dir"]) {
        cell.imageView.image = [UIImage imageNamed:@"dictionary"];
    } else if ([file.type isEqualToString:@"file"]) {
        cell.imageView.image = [UIImage imageNamed:@"file"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath%@",indexPath);
    HDZReposContent *file = self.contents[indexPath.row];
    if ([file.type isEqualToString:@"dir"]) {
        [self performSegueWithIdentifier:segueIdentifierOfDictionary sender:indexPath];
    } else if ([file.type isEqualToString:@"file"]) {
        [self performSegueWithIdentifier:segueIdentifierOfFile sender:indexPath];
    }
}
//避免点击cell直接执行prepareForSegue，shouldPerformSegueWithIdentifier返回NO不影响didSelectRowAtIndexPath
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return sender == self;
}
//As the segue is triggered from a cell in our table view, the sender object in the prepareForSegue will be the cell itself
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *indexpath = sender;
    if ([segue.identifier isEqualToString:segueIdentifierOfDictionary]) {
        HDZRepositoriesDictionaryController *dictVC = segue.destinationViewController;
        [self loadDictionaryInController:dictVC indexPath:indexpath];
        
    } else if ([segue.identifier isEqualToString:segueIdentifierOfFile]){
        HDZRepositoriesContentViewController *contentVC = segue.destinationViewController;
        [self loadContentInController:contentVC indexPath:indexpath];
    }
}

- (void)loadDictionaryInController:(HDZRepositoriesDictionaryController *)VC
                   indexPath:(NSIndexPath *)indexPath{
    HDZReposContent *content = self.contents[indexPath.row];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:content.url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        VC.contents = [NSArray yy_modelArrayWithClass:[HDZReposContent class] json:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",NSStringFromSelector(_cmd),error);
    }];
}

- (void)loadContentInController:(HDZRepositoriesContentViewController *)VC
                   indexPath:(NSIndexPath *)indexPath{
    HDZReposContent *content = self.contents[indexPath.row];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *URL = [NSURL URLWithString:content.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request addValue:@"application/vnd.github.v3.html" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        VC.htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }];
    [dataTask resume];
}


@end
