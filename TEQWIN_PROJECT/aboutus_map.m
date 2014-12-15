//
//  aboutus_map.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 27/10/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import "aboutus_map.h"
#import "SWRevealViewController.h"
@interface aboutus_map ()

@end

@implementation aboutus_map

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    // Create coordinates from location lat/long
      [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    CLLocationCoordinate2D poiCoodinates;
    poiCoodinates.latitude = 22.308948;
    poiCoodinates.longitude= 114.226022;
    
    // Zoom to region
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750);
    
    [self.mymap setRegion:viewRegion animated:YES];
    
    // Plot pin
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.title =@"TEQWIN";
    pin.subtitle=@"觀塘興業街 31 號,興業工廠大廈 9樓E室";
    pin.coordinate = poiCoodinates;
    [self.mymap addAnnotation:pin];
}


@end
