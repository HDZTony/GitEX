//
//  UIImageView+HDZDownloadImage.h
//  iTunesSearch
//
//  Created by 何东洲 on 2018/4/3.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HDZDownloadImage)
- (NSURLSessionDownloadTask *) loadImageWithURL:(NSURL *)url;
@end
