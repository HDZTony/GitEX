//
//  MoreViewController.m
//  DesignCode
//
//  Created by hdz on 2018/7/7.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZMoreViewController.h"
#import "HDZWebViewController.h"
#import "HDZStarredTableViewController.h"
#import "HDZOwnRepositoriesTableViewController.h"
#import "AFOAuth2Manager.h"
#import "HDZUserModel.h"
#import "YYModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface HDZMoreViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avator;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *fansNumber;
@property (weak, nonatomic) IBOutlet UILabel *focuserNumber;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation HDZMoreViewController
- (IBAction)starredRepositoriesButtonTapped:(id)sender {
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HDZStarredTableViewController *StarredVC = [main instantiateViewControllerWithIdentifier:@"starredVC"];
    [self.navigationController pushViewController:StarredVC animated:YES];
}
    //404091db19912909cc1a5eb743c69625ea5020ef
- (IBAction)loginButtonTapped:(id)sender {
    //    cookie清除
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    //    缓存  清除
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString * URL = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize/?client_id=%@&state=1995&redirect_uri=https://github.com/HDZTony/StackEX&scope=user,repo,gist,notifications,admin:org,admin:public_key,admin:org_hook,write:discussion,admin:gpg_key",HDZClientID];
    [self performSegueWithIdentifier:@"More to Web" sender:URL];
    
    
}
    
- (IBAction)notificationButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"More to Web" sender:@"tongzhi"];
}
- (IBAction)eventButtonTapped:(id)sender {
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"shijian"];
    NSLog(@"login----userdefault%@",login);
}
- (IBAction)repositoriesButtonTapped:(id)sender {
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HDZOwnRepositoriesTableViewController *reposVC = [main instantiateViewControllerWithIdentifier:@"reposVC"];
    [self.navigationController pushViewController:reposVC animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * currentLogin = [defaults objectForKey:@"currentLogin"];
    NSString * currentName = [defaults objectForKey:@"currentName"];
    NSString * currentAvatarUrl = [defaults objectForKey:@"currentAvatarUrl"];
    
    if (currentLogin || currentAvatarUrl ) {
        self.loginButton.hidden = YES;
        self.account.text = currentLogin;
        self.name.text = currentName;
        NSURL *image = [NSURL URLWithString:currentAvatarUrl];
        [self.avator sd_setImageWithURL:image];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"More to Web"]) {
        UINavigationController *destinationController = segue.destinationViewController;
        HDZWebViewController *webViewController =  destinationController.viewControllers.firstObject;
        webViewController.urlString = sender;
        webViewController.callback = ^(NSString *code) {
            [self getUserInfoAction];
        };
    }else if ([segue.identifier isEqualToString:@"More to repos"]) {
        
    }else if ([segue.identifier isEqualToString:@"More to starred"]) {
        
    }
    
}

- (void)getUserInfoAction
{
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:HDZClientID];
    NSString *token= credential.accessToken;
    if (token.length<1 || !token) {
        return;
    }
    NSURL *baseURL = [NSURL URLWithString:@"https://api.github.com"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    NSString *getString = [NSString stringWithFormat:@"/user?access_token=%@",token];
    [manager GET:getString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HDZUserModel *model = [HDZUserModel yy_modelWithJSON:responseObject];
        NSString *currentLogin = model.login;
        NSString *currentAvatarUrl = model.avatarURL;
        [[NSUserDefaults standardUserDefaults] setObject:currentLogin forKey:@"currentLogin"];
        [[NSUserDefaults standardUserDefaults] setObject:currentAvatarUrl forKey:@"currentAvatarUrl"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.loginButton.hidden = YES;
            self.name.text = model.name;
            self.account.text = model.login;
            [self.avator sd_setImageWithURL:[NSURL URLWithString:model.avatarURL]];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"get error :%@",error);
        }
    }];
    
}

@end
