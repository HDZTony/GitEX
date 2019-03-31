//
//  HDZUsersCollectionViewCell.m
//  StackEX
//
//  Created by hdz on 2018/9/6.
//  Copyright © 2018年 mobi.hdz. All rights reserved.
//

#import "HDZUsersCollectionViewCell.h"
#import "HDZUsers.h"
#import "UIImageView+HDZDownloadImage.h"
@interface HDZUsersCollectionViewCell()
@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;
@end
@implementation HDZUsersCollectionViewCell
- (void)configureForResult:(HDZUsers *)result{
    self.name.text = result.name;
    NSURL *imageURL = [NSURL URLWithString:result.profileImage];
    self.downloadTask = [self.profileImageView loadImageWithURL:imageURL];
}
- (void)prepareForReuse{
    [super prepareForReuse];
    [self.downloadTask cancel];
    self.downloadTask = nil;
}
@end
