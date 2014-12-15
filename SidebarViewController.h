//
//  SidebarViewController.h
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface SidebarViewController : UIViewController <FBLoginViewDelegate>
{
    NSMutableArray *list;
    NSArray *imageFilesArray;
}
@property (weak, nonatomic) IBOutlet UILabel *loginname;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *welcome;
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;


@end
