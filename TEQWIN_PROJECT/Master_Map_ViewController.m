//
//  Master_Map_ViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 29/7/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import "Map_ViewController.h"
#import "Master_Map_ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Tattoo_Detail_ViewController.h"
@interface Master_Map_ViewController ()

@end

@implementation Master_Map_ViewController

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
    poiCoodinates.latitude = [self.tattoomasterCell.latitude doubleValue];
    poiCoodinates.longitude= [self.tattoomasterCell.longitude doubleValue];
    
    MKPlacemark *place=[[MKPlacemark alloc]
                                initWithCoordinate:
                                CLLocationCoordinate2DMake(poiCoodinates.latitude,poiCoodinates.longitude)
                                addressDictionary:nil];
    MKMapItem *pin =[[MKMapItem alloc]
                           initWithPlacemark:place];
    
    pin.name =self.tattoomasterCell.name;
    pin.phoneNumber =self.tattoomasterCell.tel;
    
    
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
