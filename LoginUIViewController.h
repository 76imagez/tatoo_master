//
//  LoginUIViewController.h
//  FBLoginUIControlSample
//
//  Created by Luz Caballero on 9/17/13.
//  Copyright (c) 2013 Facebook Inc. All rights reserved.
//
#import "TattooMasterCell.h"
#import "Tattoo_Detail_ViewController.h"
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import <Parse/PFLogInViewController.h>
@interface LoginUIViewController : UIViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate,UITableViewDataSource, UITableViewDelegate>
{
 

    NSArray *imageFilesArray;
    NSMutableArray *imagesArray;
    PFObject *selectobject;
    NSString * favstring;
    NSString * like_update;
    NSArray * colorstring;
    NSString *str;
    NSMutableArray *list;
    PFImageView *sex_statues;
    UIButton *gallary_button;
    PFImageView *gallary_image;
    NSArray * countarray;
}
@property (weak, nonatomic) IBOutlet UIButton *logout;

@property (nonatomic, assign) BOOL isclicked;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *bookmark;
@property (weak, nonatomic) IBOutlet UIImageView *bookmark_btn;
@property (weak, nonatomic) IBOutlet UIImageView *like_btn;
- (IBAction)GOGALLARY:(id)sender;

@property (nonatomic, strong) TattooMasterCell *tattoomasterCell;
@property (nonatomic, assign) BOOL isFav;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profile_image;
@property (weak, nonatomic) IBOutlet UITableView *TABLEVIEW;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *fbprofile;
- (IBAction)showlike:(id)sender;
- (IBAction)showbookmark:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bookmarks_count;
@property (weak, nonatomic) IBOutlet UILabel *liked_count;


- (IBAction)logOutButtonTapAction:(id)sender;






@end
