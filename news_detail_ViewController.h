//
//  news_detail_ViewController.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 5/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "TattooMasterCell.h"
@interface news_detail_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *news_detail;

@property (weak, nonatomic) IBOutlet UILabel *view_count;
@property (weak, nonatomic) IBOutlet PFImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) TattooMasterCell *tattoomasterCell;
@end
