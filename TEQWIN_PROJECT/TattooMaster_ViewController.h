//
//  TattooMaster_ViewController.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 28/7/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TattooMasterCell.h"
#import "Tattoo_Detail_ViewController.h"
#import <Parse/Parse.h>

@interface TattooMaster_ViewController : PFQueryTableViewController{
    NSArray *imageFilesArray;
    NSMutableArray *imagesArray;
    PFObject *selectobject;
    NSArray * count;
    NSString * like_status;
     NSString * heart_status;
    NSArray * hehe;
    PFObject * object_id;
    PFImageView *heart_statues;
    PFImageView *sex_statues;
    NSIndexPath *indexPath;
    NSArray*imageFilesArray_image;
    PFQuery * searchquery;
    PFObject *gallary_object;
     PFQuery * gallary_query;
         NSArray * gallary_array;
    PFObject *master_object;
    UIButton *gallary_button;
    PFImageView *gallary_image;
     NSArray * master_array;
    PFQuery *query;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedcontroller;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property IBOutlet UISearchBar *searchbar;
- (IBAction)showsearch:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSearch;

- (IBAction)gogallery:(id)sender;

@property (nonatomic, assign) BOOL isFav;



@property (strong,nonatomic) NSMutableArray *filteredCandyArray;

@property (strong, nonatomic) IBOutlet UITableView *table_view;

@end
