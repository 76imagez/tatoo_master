//
//  aboutus_map_detail.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 27/10/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import "aboutus_map_detail.h"

@interface aboutus_map_detail ()

@end

@implementation aboutus_map_detail

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
    MKMapItem * currentLocation =[MKMapItem mapItemForCurrentLocation];
    CLLocationCoordinate2D poiCoodinates;
    poiCoodinates.latitude = 22.308948;
    poiCoodinates.longitude= 114.226022;
    
    MKPlacemark *place=[[MKPlacemark alloc]
                        initWithCoordinate:
                        CLLocationCoordinate2DMake(poiCoodinates.latitude,poiCoodinates.longitude)
                        addressDictionary:nil];
    MKMapItem *pin =[[MKMapItem alloc]
                     initWithPlacemark:place];
    
    pin.name =@"TEQWIN";
    pin.phoneNumber =@"觀塘興業街 31 號,興業工廠大廈 9樓E室";
    
    
    NSArray *array =[[NSArray alloc]initWithObjects:currentLocation,pin, nil];
    
    NSDictionary * param =[NSDictionary dictionaryWithObject://MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
                           MKLaunchOptionsDirectionsModeWalking forKey:MKLaunchOptionsDirectionsModeKey];
    [MKMapItem openMapsWithItems:array launchOptions:param];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
