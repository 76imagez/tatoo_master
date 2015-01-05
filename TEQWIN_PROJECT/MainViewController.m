//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//
#import "ImageExampleCell.h"
#import "LoginUIViewController.h"
#import "Tattoo_Master_Info.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "Tattoo_Detail_ViewController.h"
#import "TattooMasterCell.h"
#import "news_detail_ViewController.h"
@interface MainViewController ()

{
     int lastClickedRow;
    HomeModel *_homeModel;
    NSArray *_feedItems;
    Tattoo_Master_Info *_selected_tattoo_master;
   
}
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;


@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
                //然后这里设定关联，此处把indexPath关联到alert上
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"需要登入嗎？"
                                                       delegate:self
                                              cancelButtonTitle:@"否"
                                              otherButtonTitles:@"是",nil];

        [alert show];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else   {
    
        // app already launched
    }
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

    [self queryParseMethod];
    [self queryParseMethod_1];
    // scroll search bar out of sight
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.image_collection setCollectionViewLayout:flowLayout];
    
    flowLayout.itemSize = CGSizeMake(320, 163);
    
    [flowLayout setMinimumLineSpacing:0.0f];
    // self.screenName = @"Main";
    
    searchquery = [PFQuery queryWithClassName:@"Tattoo_Master"];
    //[query whereKey:@"Name" containsString:searchTerm];
    searchquery.cachePolicy=kPFCachePolicyNetworkElseCache;
    // NSLog(@"%@",[PFInstallation currentInstallation].objectId);
   // [flowLayout setMinimumLineSpacing:0.0f];

   // int randomImgNumber = arc4random_uniform(5);

   // PFObject *object = [imageFilesArray objectAtIndex:randomImgNumber];
     self.title = @"主頁";
//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.view.backgroundColor = [UIColor blackColor];
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
   }



- (void)viewWillAppear:(BOOL)animated {
  [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
   
  // self.page.numberOfPages = [imageFilesArray count];
}
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    
}
- (void)queryParseMethod_1 {
      PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"Master_id" equalTo:@"1"];
    [query whereKey:@"update_allert" equalTo:[NSNumber numberWithBool:YES]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
           if ([objects count] == 0) {
           }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下載最新版本"
                                                            message:@"需要前往App Store嗎？"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"前往",nil];
            
            [alert show];
        }}];}
- (void)queryParseMethod {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query whereKey:@"promotion_approve" equalTo:[NSNumber numberWithBool:YES]];
    
    [query orderByAscending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
        }
        if (!error) {
            
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
             self.page.numberOfPages = imageFilesArray.count;
           NSUInteger randomIndex = arc4random() % imageFilesArray.count;
            NSLog(@"xaxa%lu",(unsigned long)randomIndex);
            
            
           [_image_collection reloadData];
       
         //   NSLog(@"%@",imageFilesArray);
            [hud hide:YES];

        }
   
    }];


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *button = [alertView buttonTitleAtIndex:buttonIndex];
    if([button isEqualToString:@"是"])
    {
        LoginUIViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginUIViewController"];
    [self.navigationController pushViewController:mapVC animated:YES];
  

    }
    if([button isEqualToString:@"前往"])
    {
        NSURL *itunesURL = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id946737069"];
        [[UIApplication sharedApplication] openURL:itunesURL];
        
        
    }

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

    // Return the number of rows in the section.
    if (tableView == self.main_tableview) {
        
    return [news_array count];
        
    } else {
        //NSLog(@"how many in search results");
        //NSLog(@"%@", self.searchResults.count);
        return self.searchResults.count;
        
    }
}
-(void)filterResults:(NSString *)searchTerm scope:(NSString*)scope
{

    [self.searchResults removeAllObjects];
    
    
    
    NSArray *results  = [searchquery findObjects];
    searchquery.cachePolicy=kPFCachePolicyCacheElseNetwork;
    [self.searchResults addObjectsFromArray:results];
    
    NSPredicate *searchPredicate =
    [NSPredicate predicateWithFormat:@"Name CONTAINS[cd]%@", searchTerm];
    _searchResults = [NSMutableArray arrayWithArray:[results filteredArrayUsingPredicate:searchPredicate]];
    
    // if(![scope isEqualToString:@"全部"]) {
    // Further filter the array with the scope
    //   NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"Gender contains[cd] %@", scope];
    
    //  _searchResults = [NSMutableArray arrayWithArray:[_searchResults filteredArrayUsingPredicate:resultPredicate]];
}//}

//當search 更新時， tableview 就會更新，無論scope select 咩
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchTerm
{
    [self filterResults :searchTerm
                   scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                          objectAtIndex:[self.searchDisplayController.searchBar
                                         selectedScopeButtonIndex]]];
    
    return YES;
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        PFObject* object = self.searchResults[indexPath.row];

       
        cell.textLabel.text = [object objectForKey:@"Name"];
        cell.detailTextLabel.text =[object objectForKey:@"Gender"];
        
    }

      return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.image_collection.frame.size.width;
    self.page.currentPage = self.image_collection.contentOffset.x / pageWidth;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
  
    
    return [imageFilesArray count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"imageCell";
    ImageExampleCell *cell = (ImageExampleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.parseImage.image=[UIImage imageNamed:@"tatoo_main.png"];
cell.thumbnail.image=[UIImage imageNamed:@"ICON.PNG"];
     PFImageView *thumbnail = (PFImageView*)[cell viewWithTag:167];
    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
      PFFile *avstar = [imageObject objectForKey:@"image"];
    
    UILabel *name = (UILabel*) [cell viewWithTag:166];
    name.text = [imageObject objectForKey:@"Name"];
    
   
    PFFile *imageFile = [imageObject objectForKey:@"promotion"];
    cell.loadingSpinner.hidden = NO;
    [cell.loadingSpinner startAnimating];

    CGSize itemSize = CGSizeMake(50, 50);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    cell.thumbnail.layer.backgroundColor=[[UIColor clearColor] CGColor];
    cell.thumbnail.layer.cornerRadius= cell.thumbnail.frame.size.width/2;
    cell.thumbnail.layer.borderWidth=0.0;
   cell.thumbnail.layer.masksToBounds = YES;
   cell.thumbnail.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    [ cell.thumbnail.image drawInRect:imageRect];
    cell.thumbnail.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.thumbnail.file=avstar;
     [ cell.thumbnail loadInBackground];
  
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
             cell.parseImage.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            cell.parseImage.image = [UIImage imageWithData:data];
            [cell.loadingSpinner stopAnimating];
            cell.loadingSpinner.hidden = YES;
           
                  }
    }];
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.main_tableview) {
        
        selectobject = [news_array  objectAtIndex:indexPath.row];
        NSLog(@"%@",[selectobject objectForKey:@"Master_id"]);
    } else {
        //NSLog(@"how many in search results");
        //NSLog(@"%@", self.searchResults.count);
        
        selectobject = [_searchResults  objectAtIndex:indexPath.row];
        NSLog(@"%@",[selectobject objectForKey:@"Master_id"]);
        Tattoo_Detail_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Tattoo_Detail_ViewController"];
        [self.navigationController pushViewController:mapVC animated:YES];
        TattooMasterCell * tattoomasterCell = [[TattooMasterCell alloc] init];
        tattoomasterCell.object_id = [selectobject objectForKey:@"object"];
        tattoomasterCell.favorites = [selectobject objectForKey:@"favorites"];
        tattoomasterCell.name = [selectobject objectForKey:@"Name"];
        tattoomasterCell.imageFile = [selectobject objectForKey:@"image"];
        tattoomasterCell.gender = [selectobject objectForKey:@"Gender"];
        tattoomasterCell.tel = [selectobject objectForKey:@"Tel"];
        tattoomasterCell.email = [selectobject objectForKey:@"Email"];
        tattoomasterCell.address = [selectobject objectForKey:@"Address"];
        tattoomasterCell.latitude = [selectobject objectForKey:@"Latitude"];
        tattoomasterCell.longitude = [selectobject objectForKey:@"Longitude"];
        tattoomasterCell.website = [selectobject objectForKey:@"Website"];
        tattoomasterCell.personage = [selectobject objectForKey:@"Personage"];
        tattoomasterCell.master_id = [selectobject objectForKey:@"Master_id"];
        tattoomasterCell.imageFile = [selectobject objectForKey:@"image"];
        tattoomasterCell.gallery_m1 = [selectobject objectForKey:@"Gallery_M1"];
          tattoomasterCell.desc = [selectobject objectForKey:@"description"];
        tattoomasterCell.object_id = selectobject.objectId;
        
        mapVC.tattoomasterCell = tattoomasterCell;
        NSLog(@"%@",tattoomasterCell.master_id);
    }
    
    
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
 //   PFObject* selectobject = [imageFilesArray  objectAtIndex:indexPath.row];
 //   NSLog(@"%@",[selectobject objectForKey:@"Master_id"]);
 //   Tattoo_Detail_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Tattoo_Detail_ViewController"];
 //   [self.navigationController pushViewController:mapVC animated:YES];
 //   TattooMasterCell * tattoomasterCell = [[TattooMasterCell alloc] init];
//    tattoomasterCell.object_id = [selectobject objectForKey:@"object"];
 //   tattoomasterCell.favorites = [selectobject objectForKey:@"favorites"];
  //  tattoomasterCell.bookmark = [selectobject objectForKey:@"bookmark"];
 //   tattoomasterCell.name = [selectobject objectForKey:@"Name"];
 //   tattoomasterCell.imageFile = [selectobject objectForKey:@"image"];
 //   tattoomasterCell.gender = [selectobject objectForKey:@"Gender"];
 //   tattoomasterCell.tel = [selectobject objectForKey:@"Tel"];
 //   tattoomasterCell.email = [selectobject objectForKey:@"Email"];
  //  tattoomasterCell.address = [selectobject objectForKey:@"Address"];
  //  tattoomasterCell.latitude = [selectobject objectForKey:@"Latitude"];
  //  tattoomasterCell.longitude = [selectobject objectForKey:@"Longitude"];
  //  tattoomasterCell.website = [selectobject objectForKey:@"Website"];
  //  tattoomasterCell.personage = [selectobject objectForKey:@"Personage"];
  //  tattoomasterCell.master_id = [selectobject objectForKey:@"Master_id"];
  //  tattoomasterCell.imageFile = [selectobject objectForKey:@"image"];
  //  tattoomasterCell.gallery_m1 = [selectobject objectForKey:@"Gallery_M1"];
  //  tattoomasterCell.object_id = selectobject.objectId;
    
  //  mapVC.tattoomasterCell = tattoomasterCell;
   // NSLog(@"%@",tattoomasterCell.master_id);
//}





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"godetail"]) {
        

        NSIndexPath *indexPath = [self.image_collection indexPathForCell:sender];

        Tattoo_Detail_ViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [imageFilesArray objectAtIndex:indexPath.row];
        TattooMasterCell *tattoomasterCell = [[TattooMasterCell alloc] init];
   
        tattoomasterCell.object_id = [object objectForKey:@"object"];
        tattoomasterCell.favorites = [object objectForKey:@"favorites"];
        tattoomasterCell.bookmark =[object objectForKey:@"bookmark"];
        tattoomasterCell.name = [object objectForKey:@"Name"];
        tattoomasterCell.imageFile = [object objectForKey:@"image"];
  
   
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
        tattoomasterCell.gallery_m1 = [object objectForKey:@"Gallery_M1"];
        tattoomasterCell.object_id = object.objectId;
        tattoomasterCell.desc=[object objectForKey:@"description"];
         tattoomasterCell.promotion=[object objectForKey:@"promotion"];
    
        destViewController.tattoomasterCell = tattoomasterCell;
        NSDictionary *dimensions = @{ @"name":[object objectForKey:@"Name"]};
        [PFAnalytics trackEvent:@"clickedpromotion" dimensions:dimensions];
      //  NSInteger myInteger = [tattoomasterCell.view integerValue];
        //object[@"view"] =[NSNumber numberWithFloat:(myInteger+ 1)];
        //[object saveInBackground];
        //NSLog(@"%@",object[@"view"]);
        [object addUniqueObject:[PFInstallation currentInstallation].objectId forKey:@"view"];
        [object saveInBackground];
               }
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
        tattoomasterCell.desc=[object objectForKey:@"description"];
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
