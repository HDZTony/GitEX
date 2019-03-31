//
//  UIImageView+HDZDownloadImage.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/3.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "UIImageView+HDZDownloadImage.h"

@implementation UIImageView (HDZDownloadImage)
- (NSURLSessionDownloadTask *) loadImageWithURL:(NSURL *)url{
    NSURLSession *session = [NSURLSession sharedSession];
    __weak UIImageView *weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImageView *innerSelf = weakSelf;
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        if (error == nil && data) {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                innerSelf.image = image;
            });
        }
    }];
    [downloadTask resume];
    return downloadTask;
}
@end
