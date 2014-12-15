//
//  HomeModel.h
//  fyp_Resturant
//
//  Created by leung yan chui on 14/5/14.
//  Copyright (c) 2014年 leung yan chui. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface HomeModel : NSObject

@property (nonatomic, weak) id<HomeModelProtocol> delegate;

- (void)downloadItems;
@end
