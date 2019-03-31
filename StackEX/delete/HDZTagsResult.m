//
//  HDZSearchResult.m
//  iTunesSearch
//
//  Created by 何东洲 on 2018/3/29.
//  Copyright © 2018年 何东洲. All rights reserved.
//

#import "HDZTagsResult.h"
@implementation HDZTagsArray
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"items" : [HDZTagsResult class]};
}
@end

@implementation HDZTagsResult

//+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
//    return @{@"imageSmall" : @"artworkUrl60",
//             @"imageLarge" : @"artworkUrl100",
//             @"itemGenre" : @"primaryGenreName",
//             @"bookGenre" : @"genres",
//             @"itemPrice" : @"price"
//             };
//}





@end
    
    
