//
//  WebViewViewController.h
//  DesignCode
//
//  Created by hdz on 2018/7/7.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface HDZWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (copy, nonatomic)NSString *urlString;
@property(nonatomic,copy) void (^callback) (NSString* code);// login callback
@end
