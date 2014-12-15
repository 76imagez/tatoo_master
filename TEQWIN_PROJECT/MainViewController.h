//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import <Parse/Parse.h>
#import "TattooMasterCell.h"
//#import "GAITrackedViewController.h"
@protocol passNames <NSObject>


@end
@interface MainViewController : UIViewController <HomeModelProtocol>
{
     PFObject *selectobject;
    NSArray *news_array;
    NSArray *imageFilesArray;
    NSMutableArray *imagesArray;
      PFQuery * searchquery;
    NSArray * page_count;
}
@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property (weak, nonatomic) IBOutlet UILabel *font;

@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@property (nonatomic, strong) TattooMasterCell *tattoomasterCell;
@property (weak, nonatomic) IBOutlet PFImageView *main_image;
@property (weak, nonatomic) IBOutlet UICollectionView *image_collection;
@property (weak, nonatomic) IBOutlet UITableView *main_tableview;


@end
