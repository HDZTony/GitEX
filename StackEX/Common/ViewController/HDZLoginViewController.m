//
//  HDZLoginViewController.m
//  StackEX
//
//  Created by hdz on 2019/4/10.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZLoginViewController.h"
#import "HDZWebViewController.h"
#import "AFOAuth2Manager.h"
#import "HDZUserModel.h"
#import "YYModel.h"
@interface HDZLoginViewController ()

@end

@implementation HDZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"login to web"]) {
        UINavigationController *destinationController = segue.destinationViewController;
        HDZWebViewController *webViewController =  destinationController.viewControllers.firstObject;
        webViewController.urlString = sender;
        webViewController.callback = ^(NSString *code) {
            [self getUserInfoAction];
        };
}
    
}
- (void)getUserInfoAction {
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
        NSString *currentName = model.name;
        NSString *currentAvatarUrl = model.avatarURL;
        [[NSUserDefaults standardUserDefaults] setObject:currentLogin forKey:@"currentLogin"];
        [[NSUserDefaults standardUserDefaults] setObject:currentName forKey:@"currentName"];
        [[NSUserDefaults standardUserDefaults] setObject:currentAvatarUrl forKey:@"currentAvatarUrl"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UITabBarController *mainVC = [main instantiateInitialViewController];
        [self showViewController:mainVC sender:self] ;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"get error :%@",error);
        }
    }];
    
}

- (IBAction)loginButtonTap:(id)sender {
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
    [self performSegueWithIdentifier:@"login to web" sender:URL];
}

    
@end
