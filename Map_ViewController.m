//
//  Map_ViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 5/8/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import "SWRevealViewController.h"
#import "Map_ViewController.h"
#import "Tattoo_Master_Info.h"
#import "Tattoo_Detail_ViewController.h"
#import "Master_Map_ViewController.h"
@interface Map_ViewController ()

@end

@implementation Map_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=self.tattoomasterCell.name;
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    // Create coordinates from location lat/long

    CLLocationCoordinate2D poiCoodinates;
    poiCoodinates.latitude = [self.tattoomasterCell.latitude doubleValue];
    poiCoodinates.longitude= [self.tattoomasterCell.longitude doubleValue];
    
    // Zoom to region
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750);
    
    [self.mymap setRegion:viewRegion animated:YES];
    
    // Plot pin
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.title =self.tattoomasterCell.name;
    pin.subtitle=self.tattoomasterCell.address;
    pin.coordinate = poiCoodinates;
    [self.mymap addAnnotation:pin];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"gogoogle"]) {
        if ([segue.destinationViewController isKindOfClass:[Master_Map_ViewController  class]]){
            // Get reference to the destination view controller
            Master_Map_ViewController *detailVC = segue.destinationViewController;
            // Set the property to the selected location so when the view for
            // detail view controller loads, it can access that property to get the feeditem obj
            detailVC.tattoomasterCell=_tattoomasterCell;
            
            ;
            
        }
        else
        {}
    }
    
    
    
}


@end
