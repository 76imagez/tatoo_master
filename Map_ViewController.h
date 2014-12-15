//
//  Map_ViewController.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 5/8/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Tattoo_Master_Info.h"
#import "TattooMasterCell.h"
@interface Map_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mymap;
@property (strong, nonatomic) TattooMasterCell * tattoomasterCell;
@end
