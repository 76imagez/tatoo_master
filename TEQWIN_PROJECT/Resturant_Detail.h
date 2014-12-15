//
//  Resturant_Detail.h
//  fyp_Resturant
//
//  Created by leung yan chui on 14/5/14.
//  Copyright (c) 2014年 leung yan chui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Resturant_Info.h"
#import <MessageUI/MessageUI.h>
@interface Resturant_Detail :UIViewController<MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *list;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *rest_image;
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property (strong, nonatomic) Resturant_Info *selectedResturant;
@end