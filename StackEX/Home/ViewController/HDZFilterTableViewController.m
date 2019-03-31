//
//  HDZOptionsTableViewController.m
//  StackEX
//
//  Created by hdz on 2019/1/21.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZFilterTableViewController.h"
#import "YYModel.h"
#import "HDZLanguageModel.h"
#import "HDZFilterTableViewCell.h"
typedef void (^HDZFilterViewControllerSaveBlock)(NSString *since ,NSString * language);

@interface HDZFilterTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
//根据json数据转换的数组
@property (nonatomic,copy) NSArray <HDZLanguageModel *> *languageArray;
//key为每一节的标题，value为一节中所有的语言模型。
@property (nonatomic,copy) NSMutableDictionary <NSString *,NSArray *> *languagesDict;
//每一节的标题
@property (nonatomic,copy) NSMutableArray <NSString *> *sectionTitles;
@property (strong, nonatomic)UITableViewCell *currentSelectedCell;
@property (strong, nonatomic)NSIndexPath *currentSelectedCellIndexPath;
@property (nonatomic,copy) HDZFilterViewControllerSaveBlock save;


@end

@implementation HDZFilterTableViewController
- (void)setSaveBlock:(void (^)(NSString *since ,NSString * language))block{
    self.save = block;
}
- (NSArray<HDZLanguageModel *> *)languageArray{
    if (!_languageArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"language" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        _languageArray = [NSArray yy_modelArrayWithClass:[HDZLanguageModel class] json:data];
    }
    return _languageArray;
}


- (NSMutableDictionary *)languagesDict{
    if (!_languagesDict) {
        _languagesDict = [NSMutableDictionary new];
        //处理字母开头的语言
        for (char i = 'A'; i <= 'Z'; i++) {
            NSString *c = [NSString stringWithFormat:@"%c",i];
            NSPredicate *p = [NSPredicate predicateWithFormat:@"name beginswith[c] %@",c];
            NSArray *a = [self.languageArray filteredArrayUsingPredicate:p];
            if (a) {
                _languagesDict[c] = a;
            }
            
        }
        //处理非字母开头的语言
        for (char i = 'A'; i <= 'Z'; i++) {
            NSString *c = [NSString stringWithFormat:@"%c",i];
            NSPredicate *p = [NSPredicate predicateWithFormat:@"name beginswith[c] %@",c];
            NSCompoundPredicate *notAlpha = [NSCompoundPredicate notPredicateWithSubpredicate:p];
            NSArray *notArray = [self.languageArray filteredArrayUsingPredicate:notAlpha];
            self.languageArray = notArray;
        }
        _languagesDict[@"#"] = self.languageArray;
        self.languageArray = nil;
    }
    return _languagesDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionTitles = [[[self.languagesDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    //取消section之间的线                 
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (IBAction)save:(id)sender {
    if (self.save) {
        NSString *sectionTitle = self.sectionTitles[self.currentSelectedCellIndexPath.section];
        NSArray *modelArray = self.languagesDict[sectionTitle];
        HDZLanguageModel *item = modelArray[self.currentSelectedCellIndexPath.row];
        NSString *languageParam = item.urlParam;
        NSInteger time = self.segmentedControl.selectedSegmentIndex;
        NSString *since;
        switch (time) {
            case 0:
                 since = @"daily";
                break;
            case 1:
                since = @"weekly";
                break;
            case 2:
                since = @"monthly";
                break;

        }
        self.save(since, languageParam);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *title = self.sectionTitles[section];
    NSArray *language = [self.languagesDict objectForKey:title];
    return [language count];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sectionTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionTitle = self.sectionTitles[indexPath.section];
    NSArray *item = self.languagesDict[sectionTitle];
    HDZLanguageModel *title = item[indexPath.row];
    HDZFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HDZFilterTableViewCell" forIndexPath:indexPath];
    [cell configureCellWithModel:title];
        return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置圆角section
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 10.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 15, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //打钩
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //取消上一个勾
    self.currentSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    self.currentSelectedCell = cell;
    self.currentSelectedCellIndexPath = indexPath;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitles;
}

/**
 根据节标题返回对应节在tableview中的索引。

 @param tableView <#tableView description#>
 @param title <#title description#>
 @param index <#index description#>
 @return <#return value description#>
 */
//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    return 0;
//}

@end
