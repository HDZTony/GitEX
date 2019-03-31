//
//  WebViewViewController.m
//  DesignCode
//
//  Created by hdz on 2018/7/7.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZWebViewController.h"
#import "AFOAuth2Manager.h"

@interface HDZWebViewController ()<WKNavigationDelegate>

@end

@implementation HDZWebViewController
- (IBAction)doneButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionButtonTapped:(id)sender {
    NSArray *activityItems = @[self.urlString];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityController.excludedActivityTypes = @[UIActivityTypePostToFacebook];
    [self presentViewController:activityController animated:YES completion:nil];
}
- (IBAction)safariButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlString] options:@{} completionHandler:nil];
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)reload:(id)sender {
    [self.webView reload];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate = self;

}
- (void)dealloc
{
    if ([self isViewLoaded]) {
        [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        if (self.webView.estimatedProgress == 1.0) {
            self.navigationItem.title = self.webView.title;
        }else{
            self.navigationItem.title = @"Loading";
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//called when the loading begins
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
//called when the page load completes
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *requestUrl = webView.URL.absoluteString;
    for (int i=0; i<requestUrl.length-5; i++) {
        if ([[requestUrl substringWithRange:NSMakeRange(i, 5)] isEqualToString:@"code="]) {
            [self loginTokenAction:[requestUrl substringWithRange:NSMakeRange(i+5, 20)]];
            return;
        }
    }
}

- (void)loginTokenAction:(NSString *)code
{
     NSURL *baseURL = [NSURL URLWithString:@"https://github.com"];
     AFOAuth2Manager *oAuthManager = [[AFOAuth2Manager alloc] initWithBaseURL:baseURL clientID: HDZClientID secret:HDZClientSecret];
    [oAuthManager authenticateUsingOAuthWithURLString:@"/login/oauth/access_token" code:code redirectURI:@"https://github.com/HDZTony/StackEX" success:^(AFOAuthCredential * _Nonnull credential) {
        [AFOAuthCredential storeCredential:credential withIdentifier:HDZClientID];
        if (self->_callback) {
            self->_callback(@"success");
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        return ;
    } failure:^(NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
}

@end
