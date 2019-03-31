//
//  HDZFooterTableViewCell.m
//  StackEX
//
//  Created by hdz on 2019/3/6.
//  Copyright © 2019 mobi.hdz. All rights reserved.
//

#import "HDZFooterTableViewCell.h"
//#import "HDZReadMe.h"
#import <WebKit/WebKit.h>
@interface HDZFooterTableViewCell()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayoutConstraint;
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@end
@implementation HDZFooterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.navigationDelegate = self;
}

-(void)configureFooterViewWithHtmlString:(NSString *)string{
    NSString *footerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    [self.webView loadHTMLString:[footerString stringByAppendingString:string] baseURL:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.heightLayoutConstraint.constant = webView.scrollView.contentSize.height;
    //刷新webView的高度
    [self.VC.tableView beginUpdates];
    [self.VC.tableView endUpdates];
    
}

@end
