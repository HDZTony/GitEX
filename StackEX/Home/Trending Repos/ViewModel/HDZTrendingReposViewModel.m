//
//  HDZTrendingViewModel.m
//  StackEX
//
//  Created by hdz on 2018/10/24.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import "HDZTrendingReposViewModel.h"
#import "HDZTrendingRequest.h"
#import "HDZTrendingRepos.h"
#import "HDZWebService.h"
@interface HDZTrendingReposViewModel()
@property (strong, atomic) NSMutableArray <NSArray * > *modelArr;
@property (strong, nonatomic) HDZTrendingRequest *trendingRequest;
@property (strong, nonatomic) HDZWebService *client;
@property (nonatomic,assign) BOOL isFetchInProgress;
@property (weak, nonatomic) id<HDZTrendingReposViewModelDelegate > delegate;

@property (atomic,copy) NSMutableDictionary <NSString *,NSArray * >* langDict;

@end

@implementation HDZTrendingReposViewModel

-(NSUInteger)sextionItemsCount{
    return self.modelArr[0].count;
}

- (instancetype)initWithDelegate:(id<HDZTrendingReposViewModelDelegate>)delegate
{
    self = [super init];
    if (self) {
        _trendingRequest = [[HDZTrendingRequest alloc] init];
        _delegate = delegate;
        _isFetchInProgress = NO;
        _index = -1;
        _modelArr = [NSMutableArray array];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *dict = [defaults dictionaryForKey: @"trendingRepos"];
        NSLog(@"dict-%@",dict);
        if (dict.allKeys.count > 0) {
            _langDict = [dict mutableCopy];
        }else{
            _langDict = [[NSMutableDictionary alloc] init];
            
        }
        _client = [[HDZWebService alloc] init];
    }
    return self;
}

- (HDZTrendingRepos *)modelOfCollectionView:(UICollectionView *)collectionView AtIndex:(NSInteger)index{
    return self.modelArr[collectionView.tag][index];
}
-(void)fetchNew:(BOOL)first TrendingWithLanguage:(NSString *)lanaguage sine:(NSString *)time{
//    if (self.isFetchInProgress) {
//        return;
//    }
    NSString *name;
    NSString *sine;//default daily
    if (lanaguage || time) {
        name = lanaguage;
        sine = time;
    }
//    self.isFetchInProgress = YES;
    
    [self.client fetchTrendingsWithRequest:self.trendingRequest language:name time:sine success:^(NSArray * _Nonnull models) {
//        self.isFetchInProgress = NO;
            self.index += 1;
            //返回结果的顺序不确定，导致字典键值不对应。
            if (name || sine) {
                self.langDict[[@(self.index) stringValue]] = @[name,sine];
                
            }else{
                //@[@"0",@"0"]表示语言时间为空，用来占位
                self.langDict[[@(self.index) stringValue]] = @[@"0",@"0"];
            }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.langDict forKey:@"trendingRepos"];
        [defaults synchronize];
        NSLog(@"dict-%@",self.langDict);
        [self.modelArr insertObject:models atIndex:self.index];
        if ([self.delegate respondsToSelector:@selector(fetchCompletedWithModels:NewIndexPaths:)]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
            [self.delegate fetchCompletedWithModels:models NewIndexPaths:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"failed fetchTrending");
    }];
    
}
@end
