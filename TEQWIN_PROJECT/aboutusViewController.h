//
//  aboutusViewController.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 27/10/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
@interface aboutusViewController : UIViewController <MFMailComposeViewControllerDelegate>
{ NSMutableArray *list;
    NSMutableArray *intro_list;


}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
- (IBAction)segmented:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
