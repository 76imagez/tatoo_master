//
//  TattooMasterCell.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 5/9/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface TattooMasterCell : NSObject{
   
}
@property (nonatomic, strong) NSIndexPath *clickindexpath; // name of recipe
@property (nonatomic, strong) NSString *name; // name of recipe
@property (nonatomic, strong) NSString *desc; // name of recipe
@property (nonatomic, strong) NSString *gender; // name of recipe
@property (nonatomic, strong) NSString *tel; // name of recipe
@property (nonatomic, strong) NSString *email; // name of recipe
@property (nonatomic, strong) NSString *address; // name of recipe
@property (nonatomic, strong) NSString *latitude; // name of recipe
@property (nonatomic, strong) NSString *longitude; // preparation time
@property (nonatomic, strong) NSString *website; // preparation time
@property (nonatomic, strong) NSString *personage; // preparation time
@property (nonatomic, strong) NSString *master_id; // preparation time
@property (nonatomic, strong) NSString *object_id; // preparation time
@property (nonatomic, strong) NSArray *favorites; // preparation time
@property (nonatomic, strong) NSArray *bookmark; // preparation time

@property (nonatomic, strong) NSArray *view; // name of recipe
@property (nonatomic, strong) NSArray *news_view; // name of recipe
@property (nonatomic, strong) PFFile *promotion; // image of recipe
@property (nonatomic, strong) UIImage *img; // image of recipe
@property (nonatomic, strong) NSString *news; // image of recipe
@property (nonatomic, strong) PFFile *imageFile; // image of recipe
@property (nonatomic, strong) PFFile *gallery_m1; // image of gallery1
@property (nonatomic, strong) PFFile *gallery_2; // image of gallery2
@property (nonatomic, strong) PFFile *gallery_3; // image of gallery3
@property (nonatomic, strong) PFFile *gallery_4; // image of gallery4
@property (nonatomic, strong) PFFile *gallery_5; // image of gallery5
@end
