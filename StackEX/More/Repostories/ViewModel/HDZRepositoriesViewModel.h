//
//  HDZRepositoriesViewModel.h
//  StackEX
//
//  Created by hdz on 2018/12/13.
//  Copyright © 2018 mobi.hdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDZRepositories.h"
NS_ASSUME_NONNULL_BEGIN
@protocol HDZRepositoriesViewModelDelegate <NSObject>

- (void)fetchCompleted;

@end
@interface HDZRepositoriesViewModel : NSObject
@property (nonatomic,copy) NSArray<HDZRepositories *> *models;
- (instancetype)initWithDelegate:(id<HDZRepositoriesViewModelDelegate>)delegate;
- (void)fetchRepositories;
@end

NS_ASSUME_NONNULL_END
