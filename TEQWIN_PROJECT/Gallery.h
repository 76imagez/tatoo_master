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
	 UIPinchGestureRecognizer *twoFingerPinch;
	CGFloat imgStartWidth;
	CGFloat imgStartHeight;
    UIButton *button;
    BOOL isshow;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain) UIDocumentInteractionController * documentInteractionController;

@property (weak, nonatomic) IBOutlet UILabel *master_name;

- (IBAction)btn_share:(id)sender;
- (IBAction)like:(id)sender;
@property (weak, nonatomic) IBOutlet PFImageView *profileimage;
@property(nonatomic,retain) UIDocumentInteractionController *documentationInteractionController;
@property (strong, nonatomic) TattooMasterCell * tattoomasterCell;
@end
