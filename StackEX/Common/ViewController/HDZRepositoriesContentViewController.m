//
//  HDZRepositoriesContentViewController.m
//  StackEX
//
//  Created by hdz on 2019/3/10.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZRepositoriesContentViewController.h"
#import <WebKit/WebKit.h>
#import "HDZReposContent.h"
@interface HDZRepositoriesContentViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation HDZRepositoriesContentViewController

- (void)setHtmlString:(NSString *)htmlString{
    if (_htmlString == htmlString) return;
    _htmlString = htmlString;
    NSString *footerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.webView loadHTMLString:[footerString stringByAppendingString:self.htmlString] baseURL:nil];
        [self.webView reload];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate = self;
    
}


@end
