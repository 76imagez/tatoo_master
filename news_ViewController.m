//
//  news_ViewController.m
//  TEQWIN_PROJECT_Tattoo
//
//  Created by Teqwin on 13/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import "news_ViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "Tattoo_Detail_ViewController.h"
#import "TattooMasterCell.h"
#import "news_detail_ViewController.h"
@interface news_ViewController ()

@end

@implementation news_ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    self.title = @"新消息";
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.view.backgroundColor = [UIColor blackColor];
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
       [self queryParseMethod_news];
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];}
- (void)viewWillAppear:(BOOL)animated {
    // self.screenName = @"Main";
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    // self.page.numberOfPages = [imageFilesArray count];
}
- (void)queryParseMethod_news {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate   ;
    hud.labelText = @"Loading";
    [hud show:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    //query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    // [query whereKey:@"news" equalTo:self.tattoomasterCell.master_id];
    [query whereKey:@"news_approve" equalTo:[NSNumber numberWithBool:YES]];
  
    NSLog(@"%@",count_view);
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
        if (!error) {
            news_array = [[NSArray alloc] initWithArray:objects];
            [_main_tableview reloadData];
         

            count_view =[news_array valueForKey:@"news_view"];
            //   NSLog(@"%@",imageFilesArray);
            [hud hide:YES];
        }
    }];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
    // return @"最新消息";
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor grayColor];
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return [news_array count];
        
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *simpleTableIdentifier = @"favcell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.main_tableview) {
        // Configure the cell
        // Configure the cell
        PFObject *imageObject = [news_array objectAtIndex:indexPath.row];
        PFFile *thumbnail = [imageObject objectForKey:@"image"];
        PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
        CGSize itemSize = CGSizeMake(70, 70);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        thumbnailImageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
        thumbnailImageView.layer.cornerRadius=thumbnailImageView.frame.size.width/2;
        thumbnailImageView.layer.borderWidth=2.0;
        thumbnailImageView.layer.masksToBounds = YES;
        thumbnailImageView.layer.borderColor=[[UIColor whiteColor] CGColor];
        [thumbnailImageView.image drawInRect:imageRect];
        thumbnailImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
        
        thumbnailImageView.file = thumbnail;
        [thumbnailImageView loadInBackground];
        
        
        UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
        nameLabel.text = [imageObject objectForKey:@"Name"];
        
        UILabel *news = (UILabel*) [cell viewWithTag:155];
        
        news.text = [imageObject objectForKey:@"news"];
        news.textColor =[UIColor colorWithRed:234.0/255.0
                                        green:192.0/255.0 blue:94/255.0 alpha:1.0];
        // news.textColor =[UIColor grayColor];
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"gonewdetail"]) {
        NSIndexPath *indexPath = [self.main_tableview indexPathForCell:sender];
        
        news_detail_ViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [news_array objectAtIndex:indexPath.row];
        TattooMasterCell *tattoomasterCell = [[TattooMasterCell alloc] init];
        
        tattoomasterCell.object_id = [object objectForKey:@"object"];
        tattoomasterCell.favorites = [object objectForKey:@"favorites"];
        tattoomasterCell.bookmark =[object objectForKey:@"bookmark"];
        tattoomasterCell.name = [object objectForKey:@"Name"];
        tattoomasterCell.imageFile = [object objectForKey:@"image"];
        
        tattoomasterCell.news = [object objectForKey:@"news"];
        tattoomasterCell.gender = [object objectForKey:@"Gender"];
        tattoomasterCell.tel = [object objectForKey:@"Tel"];
        tattoomasterCell.email = [object objectForKey:@"Email"];
        tattoomasterCell.address = [object objectForKey:@"Address"];
        tattoomasterCell.latitude = [object objectForKey:@"Latitude"];
        tattoomasterCell.longitude = [object objectForKey:@"Longitude"];
        tattoomasterCell.website = [object objectForKey:@"Website"];
        tattoomasterCell.personage = [object objectForKey:@"Personage"];
        tattoomasterCell.master_id = [object objectForKey:@"Master_id"];
        tattoomasterCell.view = [object objectForKey:@"view"];
        tattoomasterCell.news_view = [object objectForKey:@"news_view"];
        tattoomasterCell.gallery_m1 = [object objectForKey:@"Gallery_M1"];
        tattoomasterCell.object_id = object.objectId;
        
        tattoomasterCell.promotion=[object objectForKey:@"promotion"];
        
        destViewController.tattoomasterCell = tattoomasterCell;
        //  NSInteger myInteger = [tattoomasterCell.view integerValue];
        //object[@"view"] =[NSNumber numberWithFloat:(myInteger+ 1)];
        //[object saveInBackground];
        //NSLog(@"%@",object[@"view"]);
        [object addUniqueObject:[PFInstallation currentInstallation].objectId forKey:@"news_view"];
        [object saveInBackground];
        
    }
    
}


@end
