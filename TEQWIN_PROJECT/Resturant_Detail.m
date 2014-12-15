//
//  Resturant_Detail.m
//  fyp_Resturant
//
//  Created by leung yan chui on 14/5/14.
//  Copyright (c) 2014年 leung yan chui. All rights reserved.
//

#import "Resturant_Detail.h"
#import "detail_map.h"
#import "Resturant_ViewController.h"
@interface Resturant_Detail ()
{NSArray *_feedItems;
}
@end

@implementation Resturant_Detail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;}

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        
    

//        NSURL *url = [NSURL URLWithString: @"http://localhost:8888/phpmyadmin/fyp_php/mcdonalds_logo.jpg"];
//        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        
        _rest_image.image = [UIImage imageNamed:self.selectedResturant.rest_image];
        
        UIImageView *img1 =[[[UIImageView alloc]init] initWithImage:[UIImage imageNamed:self.selectedResturant.rest_image ]];
        
        UIImageView *img2 =[[[UIImageView alloc]init] initWithImage:[UIImage imageNamed:self.selectedResturant.rest_image_2 ]];
        UIImageView *img3 =[[[UIImageView alloc]init] initWithImage:[UIImage imageNamed:self.selectedResturant.rest_image_3 ]];
        UIImageView *img4 =[[[UIImageView alloc]init] initWithImage:[UIImage imageNamed:self.selectedResturant.rest_image_4 ]];
        UIImageView *img5 =[[[UIImageView alloc]init] initWithImage:[UIImage imageNamed:self.selectedResturant.rest_image_5 ]];
        
        
        _rest_image.contentMode =UIViewContentModeScaleAspectFill;
        img1.contentMode =UIViewContentModeScaleAspectFit;
        img2.contentMode =UIViewContentModeScaleAspectFit;
        img3.contentMode =UIViewContentModeScaleAspectFit;
        img4.contentMode =UIViewContentModeScaleAspectFit;
        img5.contentMode =UIViewContentModeScaleAspectFit;
        
        
        CGRect rect =self.myScroll.frame;
        img1.frame=rect;
        
        img2.frame =CGRectOffset(img1.frame, img1.frame.size.width,0);
        img3.frame =CGRectOffset(img2.frame, img2.frame.size.width,0);
        img4.frame =CGRectOffset(img3.frame, img3.frame.size.width,0);
        
        img5.frame =CGRectOffset(img4.frame, img4.frame.size.width,0);
        
        
        
        
        [self.myScroll addSubview:img1];
        [self.myScroll addSubview:img2];
        [self.myScroll addSubview:img3];
        [self.myScroll addSubview:img4];
        [self.myScroll addSubview:img5];
        self.myScroll.minimumZoomScale = 0.5;
        self.myScroll.maximumZoomScale = 3;
        
        CGSize size =CGSizeMake(img1.frame.size.width + img2.frame.size.width + img3.frame.size.width+ img4.frame.size.width+ img5.frame.size.width,rect.origin.y);
        self.myScroll.contentSize=size;
        
        
        [self.view addSubview:  self.myScroll];

        
        
        
       _feedItems = [[NSArray alloc] init];
        list =[[NSMutableArray alloc]init];
        
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_name]];
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_address]];
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_plaza]];
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_email]];
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_tel]];
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_type]];
        
        
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_price]];
        
        [list addObject:[NSString stringWithFormat:@"%@",self.selectedResturant.rest_rate]];
        
        
    }
    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [list count];
    }
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *identifier =@"Cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        }
        switch (indexPath.row) {
                
            case 0:
                
            {
         
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Name：";
               
            }
                
                break;
                
            case 1:
                
            {
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Location：";
            }
                
                break;
                
            case 2:
                
            {
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Plaza：";
                
            }
                
                break;
                
            case 3:
                
            {
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Email：";
                
            }
                
                break;

            case 4:
                
            {
                
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Telephone：";
                
                           }
                
                break;
            case 5:
                
            {
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Type：";
                
            }
                
                break;
                
            case 6:
                
            {
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Price：";
                
            }
                
                break;
                
                default:
            {
                cell.textLabel.font = [cell.textLabel.font fontWithSize:12];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Rate：";
                
            }

        }
       
       [cell.detailTextLabel setNumberOfLines:2];
        cell.detailTextLabel.text =[list objectAtIndex:indexPath.row];
        
        cell.detailTextLabel.font = [cell.textLabel.font fontWithSize:12];
        return cell;

}
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    // Reload the table view
   
}
- (void)viewDidAppear:(BOOL)animated
{
    // Create coordinates from location lat/long
    CLLocationCoordinate2D poiCoodinates;
    poiCoodinates.latitude = [self.selectedResturant.rest_latitude doubleValue];
    poiCoodinates.longitude= [self.selectedResturant.rest_longitude doubleValue];
    
    // Zoom to region
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750);
    
    [self.mapView setRegion:viewRegion animated:YES];
    
    // Plot pin
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = poiCoodinates;
    [self.mapView addAnnotation:pin];
      [pin setTitle: self.selectedResturant.rest_name];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
            //make send email function
        case 3:
            //Create the MailComposeViewController
            
        {
            MFMailComposeViewController *Composer = [[MFMailComposeViewController alloc]init];
            
            Composer.mailComposeDelegate = self;
            // email Subject
            [Composer setSubject:self.selectedResturant.rest_name];
            //email body
            [Composer setMessageBody:@"helloworld" isHTML:NO];
            //recipient
            [Composer setToRecipients:[NSArray arrayWithObjects:self.selectedResturant.rest_email, nil]];            //get the filePath resource
            
            NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ive" ofType:@"png"];
            
            //Read the file using NSData
            
            NSData *fileData = [NSData dataWithContentsOfFile:filePath];
            
            NSString *mimeType = @"image/png";
            
            //Add attachement
            
            [Composer addAttachmentData:fileData mimeType:mimeType fileName:filePath];
            
            //Present it on the screen
            
            [self presentViewController:Composer animated:YES completion:nil];
            
            break;}
            
            //make alert box and phonecall function
        case 4:
        {
              //i not sure this phone call function is work.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:@"Make a Call?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
            [alert show];
          
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.selectedResturant.rest_tel]];
            NSLog(@"ddd");
            
            
            
            break;
            
        }
    }
}
//make mail compose controller
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error

{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail Cancelled");
            break;
            
        case MFMailComposeResultSaved:
            
            NSLog(@"Mail Saved");
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail Sent");
            break;
            
        case MFMailComposeResultFailed:
            
            NSLog(@"Mail Failed");
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Get reference to the destination view controller
    detail_map *detailVC = segue.destinationViewController;
    
    // Set the property to the selected location so when the view for
    // detail view controller loads, it can access that property to get the feeditem obj
    detailVC.selectedResturant = _selectedResturant;
}
@end
