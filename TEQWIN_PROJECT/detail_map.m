//
//  detail_map.m
//  fyp_Resturant
//
//  Created by leung yan chui on 15/5/14.
//  Copyright (c) 2014年 leung yan chui. All rights reserved.
//

#import "detail_map.h"
#import <MapKit/MapKit.h>
@interface detail_map ()

@end

@implementation detail_map

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
    poiCoodinates.latitude = [self.selectedResturant.rest_latitude doubleValue];
    poiCoodinates.longitude= [self.selectedResturant.rest_longitude doubleValue];
    
    MKPlacemark *markTaipei101=[[MKPlacemark alloc]
                                initWithCoordinate:
                                CLLocationCoordinate2DMake(poiCoodinates.latitude,poiCoodinates.longitude)
                                addressDictionary:nil];
    MKMapItem *taipei101 =[[MKMapItem alloc]
                           initWithPlacemark:markTaipei101];
    
    taipei101.name = self.selectedResturant.rest_name;
    taipei101.phoneNumber =self.selectedResturant.rest_tel;
    

    NSArray *array =[[NSArray alloc]initWithObjects:currentLocation,taipei101, nil];
    
    NSDictionary * param =[NSDictionary dictionaryWithObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
    
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
