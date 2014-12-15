//
//  Gallery.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 16/9/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "Tattoo_Detail_ViewController.h"
@interface Gallery : UIViewController <UIDocumentInteractionControllerDelegate>
{
    NSArray *imageFilesArray;
    NSMutableArray *imagesArray;
    PFFile * shareimageFile;
    UIImage *imageToShare;
    PFObject *imageObject;
    PFFile *imageFile ;
    UILabel *image_desc;
    UITextView * test;
UILabel *backtips;
    CGFloat lastDistance;
	
	CGFloat imgStartWidth;
	CGFloat imgStartHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain) UIDocumentInteractionController * documentInteractionController;

@property (weak, nonatomic) IBOutlet UILabel *master_name;
@property (weak, nonatomic) IBOutlet PFImageView *master_image;
- (IBAction)btn_share:(id)sender;
- (IBAction)like:(id)sender;

@property(nonatomic,retain) UIDocumentInteractionController *documentationInteractionController;
@property (strong, nonatomic) TattooMasterCell * tattoomasterCell;
@end
