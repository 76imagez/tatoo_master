//
//  news_ViewController.h
//  TEQWIN_PROJECT_Tattoo
//
//  Created by Teqwin on 13/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "TattooMasterCell.h"
@interface news_ViewController : UIViewController
{
    PFObject *selectobject;
    NSArray *news_array;
    NSArray *imageFilesArray;
    NSMutableArray *imagesArray;
    NSArray *count_view;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) TattooMasterCell *tattoomasterCell;
@property (weak, nonatomic) IBOutlet UITableView *main_tableview;
@end
