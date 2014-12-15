//
//  Tattoo_Detail_ViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 29/7/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//=
#import "GalleryCell.h"
#import "Gallery.h"
#import "ImageExampleCell.h"
#import "Tattoo_Detail_ViewController.h"
#import "SWRevealViewController.h"
#import "TattooMaster_ViewController.h"
#import "Master_Map_ViewController.h"


#import "Map_ViewController.h"
#import "LoginUIViewController.h"
@import CoreData;
@interface Tattoo_Detail_ViewController ()

{
    int lastClickedRow;
    CGRect frame_first;
    UIImageView *fullImageView;
    
}
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@end

@implementation Tattoo_Detail_ViewController





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
   
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    
    NSDictionary *dimensions = @{ @"name":self.tattoomasterCell.name};
    [PFAnalytics trackEvent:@"showmaster" dimensions:dimensions];
    [self queryParseMethod];
    [self queryParseMethod_image];
    if (self.tattoomasterCell.view ==nil) {
        self.view_count.text = @"1";
    }
    else{
    self.view_count.text =[NSString stringWithFormat:@"%lu",(unsigned long)self.tattoomasterCell.view.count];
    }
   //self.view_count.text =[NSString stringWithFormat:@"%d",self.tattoomasterCell.view.count    ]   ;
    self.description_textview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    if (self.tattoomasterCell.description ==nil) {
        self.description_textview.text = @"沒有簡介";
    }
    else{
    self.description_textview.text=self.tattoomasterCell.desc;
    }
     self.description_textview.layer.cornerRadius=8.0f;
     self.description_textview.layer.borderWidth=1.0f;
    self.description_textview.layer.borderColor =[[UIColor grayColor] CGColor];
  //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.view.backgroundColor =[UIColor blackColor];
    CGRect frame =  self.description_textview.frame;
    frame.size.height =  self.description_textview.contentSize.height;
    self.description_textview.frame = frame;
[ self.description_textview sizeToFit];
    [self.description_textview setScrollEnabled:YES];
    
   
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     [self.imagesCollection setCollectionViewLayout:flowLayout];
    flowLayout.itemSize = CGSizeMake(70, 70);
    self.title =self.tattoomasterCell.name;
    self.count_like.text =[NSString stringWithFormat:@"%lu likes",(unsigned long)self.tattoomasterCell.favorites.count    ]   ;
    if ([self.tattoomasterCell.gender isEqualToString:@"男"]) {
        
        
        _sexy_image.image = [UIImage imageNamed:@"male.png"];
    }
    else
        if ([self.tattoomasterCell.gender isEqualToString:@"女"]) {
            
            _sexy_image.image = [UIImage imageNamed:@"female.png"];
        }

    //set segmented control
    if ([self.tattoomasterCell.bookmark containsObject:[PFUser currentUser].objectId]) {
        self.bookmark_image.image =[UIImage imageNamed:@"icon-favorite_onn.png"];
    }
    else {
        self.bookmark_image.image =[UIImage imageNamed:@"icon-favorite_2.png"];
    }
    
    if ([self.tattoomasterCell.favorites containsObject:[PFUser currentUser].objectId]) {
        self.fav_image.image =[UIImage imageNamed:@"like.png"];
    }
        else {
            self.fav_image.image =[UIImage imageNamed:@"unlike.png"];
        }
    self.master_name.text=self.tattoomasterCell.name;
    //NSLog(@"dddd%@",self.tattoomasterCell.name);
    self.profileimage.file=self.tattoomasterCell.imageFile;
      self.profileimage.layer.cornerRadius =self.profileimage.frame.size.width / 2;
    self.profileimage.layer.borderWidth = 3.0f;
    self.profileimage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileimage.clipsToBounds = YES;
    _tableView.bounces=YES;
  
    //self.test_images.image=self.tattoomasterCell.img;
	//
	// note: the following can be done in Interface Builder, but we show this in code for clarity
	
	
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    
    
    
    
    list =[[NSMutableArray alloc]init];
   
    

    [list addObject:[NSString stringWithFormat:@"%@",self.tattoomasterCell.address]];
    [list addObject:[NSString stringWithFormat:@"%@",self.tattoomasterCell.website]];
    [list addObject:[NSString stringWithFormat:@"%@",self.tattoomasterCell.email]];
    [list addObject:[NSString stringWithFormat:@"%@",self.tattoomasterCell.tel]];
   
   // [list addObject:[NSString stringWithFormat:@"%@",self.tattoomasterCell.description]];
    
    }

- (void)viewWillAppear:(BOOL)animated {
    // scroll search bar out of sight
    //self.screenName =@"detail page";

    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1.0f;
    return 32.0f;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    } else {
        return @"xx";
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    } else {
        return @"xx";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return 1.0f;
    return 32.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (tableView == self.tableView) {
        
        return [list count];
        
    } else {
        //NSLog(@"how many in search results");
        //NSLog(@"%@", self.searchResults.count);
        return self.searchResults.count;
        
    }

}
-(void)filterResults:(NSString *)searchTerm scope:(NSString*)scope
{
    
    [self.searchResults removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    //[query whereKey:@"Name" containsString:searchTerm];
    query.cachePolicy=kPFCachePolicyCacheElseNetwork;
    NSArray *results  = [query findObjects];
    NSLog(@"%d",results.count);
    
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
- (void)queryParseMethod {
    NSLog(@"start query");
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
   
    [query whereKey:@"Master_id" equalTo:self.tattoomasterCell.master_id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
            for (PFObject *object in objects) {

            _profileimage.file =[object objectForKey:@"image"];
            [_profileimage.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                _profileimage.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                _profileimage.image = [UIImage imageWithData:data];
             }];
            }}
    }];
    
    
}
- (void)queryParseMethod_image{
    NSLog(@"start query_image");
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"Master_id" equalTo:self.tattoomasterCell.master_id];
     query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        
        if (!error) {
           
           
                imageFilesArray_image = [[NSArray alloc] initWithArray:objects];
                
                self.noimage.text=@"";
                [query orderByAscending:@"createdAt"];
                
                
                [_imagesCollection reloadData];
            }}
    ];
    
}-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imageFilesArray_image count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *cellIdentifier = @"imageCell";
    ImageExampleCell *cell = (ImageExampleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    imageObject = [imageFilesArray_image objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"image"];
    
    cell.loadingSpinner.hidden = NO;
    [cell.loadingSpinner startAnimating];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            
            CGSize itemSize = CGSizeMake(50, 50);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [ cell.parseImage.image drawInRect:imageRect];
            cell.parseImage.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext() ;
            //  UIGraphicsEndImageContext();
            cell.parseImage.image = [UIImage imageWithData:data];
            [cell.loadingSpinner stopAnimating];
            cell.loadingSpinner.hidden = YES;
            [ cell.parseImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
            
        }
    }];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
  //    Gallery * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Gallery"];
// [self.navigationController pushViewController:mapVC animated:YES];
 //    mapVC.tattoomasterCell=_tattoomasterCell;

  //   [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
  //  NSLog(@"反反反反%@",[imageFilesArray_image objectAtIndex:indexPath.row]);
   
}
//按圖第一下放大至fullscreen
////按圖第二下縮回原型



- (CGFloat) tableView: (UITableView*) tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath
{ NSString *cellText = [list objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:cellText
     attributes:@
     {
     NSFontAttributeName: cellFont
     }];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(tableView.bounds.size.width, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    return rect.size.height + 20;


  }




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.tableView.contentSize = CGSizeMake(self.tableView.frame.size.width,999);//(phoneCellHeight*phoneList.count)
    
    
    static NSString *identifier =@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    }
    if (tableView == self.tableView) {

    switch (indexPath.row) {
            
            
            
        case 0:
            
        {
            [cell.detailTextLabel setNumberOfLines:7];
            [cell.detailTextLabel setNumberOfLines:20];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15 ];
            cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
            cell.detailTextLabel.textColor=[UIColor whiteColor];
            cell.textLabel.text = @"Address：";
            //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
           // cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        }
            
            break;
        case 1:
            
        {
            [cell.detailTextLabel setNumberOfLines:5];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
            cell.detailTextLabel.textColor=[UIColor whiteColor];
            cell.textLabel.text = @"Website：";
            //cell.accessoryType=UITableViewCellAccessoryDetailButton;
        }
            
            break;
            
        case 2:
            
        {
            [cell.detailTextLabel setNumberOfLines:5];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
            cell.detailTextLabel.textColor=[UIColor whiteColor];
            cell.textLabel.text = @"Email：";
            //cell.accessoryType=UITableViewCellAccessoryDetailButton;
        }
            
            break;
            
        case 3:
            
        {
            
            [cell.detailTextLabel setNumberOfLines:5];
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
             cell.detailTextLabel.textColor=[UIColor whiteColor];
            cell.textLabel.text = @"Telephone：";
            //cell.accessoryType=UITableViewCellAccessoryDetailButton;
        }
            
            break;
            
   
      //  }
            
       //     break;
      //  case 7:
            
      //  {
      //      cell.detailTextLabel.textColor =[UIColor whiteColor];
       //    [cell.detailTextLabel setNumberOfLines:5];
       //     cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
       //     cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
      //      cell.textLabel.text = @"Description：";
            
  
       // }
    }
               cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.text =[list objectAtIndex:indexPath.row];
    
    cell.contentView.backgroundColor = [UIColor blackColor];


   
    }


    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return (action == @selector(copy:));
    
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:))
        [UIPasteboard generalPasteboard].string = [list objectAtIndex:indexPath.row];
    NSLog(@"COPY  %@",[UIPasteboard generalPasteboard].string);
}



- (void) likeImage {
   
    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"favorites"];
    
    [object saveInBackground];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            //[self likedSuccess];
             self.isFav = YES;
        }
        else {
            [self likedFail];
        }
    }];
}
- (void) dislike {
        [object removeObject:[PFUser currentUser].objectId forKey:@"favorites"];
    [object saveInBackground];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
           // [self dislikedSuccess];
             self.isFav = NO;
            
        }
        else {
            [self dislikedFail];
        }
    }];
}
- (void) dislikedSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"已經取消我的最愛" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) dislikedFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooops!" message:@"失敗" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) likedSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You have succesfully liked the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) likedFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooops!" message:@"There was an error when liking the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (tableView == self.tableView) {
    
    switch (indexPath.row) {
               case 0:{
            Map_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Map_ViewController"];
            [self.navigationController pushViewController:mapVC animated:YES];
            mapVC.tattoomasterCell=_tattoomasterCell;
            NSLog(@"%@%@",self.tattoomasterCell.latitude,self.tattoomasterCell.longitude);
        }
            break;
        case 1:{
            
            NSURL *url = [NSURL URLWithString:self.tattoomasterCell.website ];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        case 2:
            //Create the MailComposeViewController
            
        {
            MFMailComposeViewController *Composer = [[MFMailComposeViewController alloc]init];
            
            Composer.mailComposeDelegate = self;
            // email Subject
            [Composer setSubject:self.tattoomasterCell.name];
            //email body
            // [Composer setMessageBody:self.selectedTattoo_Master.name isHTML:NO];
            //recipient
            [Composer setToRecipients:[NSArray arrayWithObjects:self.tattoomasterCell.email, nil]];            //get the filePath resource
            
            // NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ive" ofType:@"png"];
            
            //Read the file using NSData
            
            //   NSData *fileData = [NSData dataWithContentsOfFile:filePath];
            
            // NSString *mimeType = @"image/png";
            
            //Add attachement
            
            //  [Composer addAttachmentData:fileData mimeType:mimeType fileName:filePath];
            
            //Present it on the screen
            
            [self presentViewController:Composer animated:YES completion:nil];
            
            break;}
            
            //make alert box and phonecall function
        case 3:
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"撥號"
                                                            message:@"確定要撥號嗎？"
                                                           delegate:self
                                                  cancelButtonTitle:@"否"
                                                  otherButtonTitles:@"是",nil];
            //然后这里设定关联，此处把indexPath关联到alert上
            
            [alert show];
            
            
            
        }
            break;
            
    }}
     else {
         //NSLog(@"how many in search results");
         //NSLog(@"%@", self.searchResults.count);
         
        PFObject* selectobject = [_searchResults  objectAtIndex:indexPath.row];
         NSLog(@"%@",[selectobject objectForKey:@"Master_id"]);
         Tattoo_Detail_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Tattoo_Detail_ViewController"];
         [self.navigationController pushViewController:mapVC animated:YES];
         TattooMasterCell * tattoomasterCell = [[TattooMasterCell alloc] init];
         tattoomasterCell.object_id = [selectobject objectForKey:@"object"];
         tattoomasterCell.favorites = [selectobject objectForKey:@"favorites"];
         tattoomasterCell.bookmark = [selectobject objectForKey:@"bookmark"];
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
         tattoomasterCell.object_id = selectobject.objectId;
         
         mapVC.tattoomasterCell = tattoomasterCell;
         NSLog(@"%@",tattoomasterCell.master_id);
     }

}
//- (IBAction)getDirectionButtonPressed:(id)sender {
// UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Get Direction"
//                                                     message:@"Go to Maps?"
//                                                  delegate:self
//                                         cancelButtonTitle:@"取消"
//                                         otherButtonTitles:@"確定", nil];
// alertView.delegate = self;
//[alertView show];
//}


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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *button = [alertView buttonTitleAtIndex:buttonIndex];
    if([button isEqualToString:@"是"])
    {
        NSString *phNo =self.tattoomasterCell.tel;
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
          UIAlertView*  calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [calert show];
        }
    }
    if([button isEqualToString:@"確定"])
    { LoginUIViewController * loginvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginUIViewController"];
        [self.navigationController pushViewController:loginvc animated:YES];

        
    }
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"GOGALLERY"]) {
        
        
        if ([segue.destinationViewController isKindOfClass:[Gallery class]]){
            NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
            Gallery *receiver = (Gallery*)segue.destinationViewController;
            receiver.tattoomasterCell=_tattoomasterCell;
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }
    if ([segue.identifier isEqualToString:@"GOGALLERY_collection"]) {
        
       
        if ([segue.destinationViewController isKindOfClass:[Gallery class]]){
            self.tattoomasterCell.clickindexpath = [self.imagesCollection indexPathForCell:sender];
            Gallery *receiver = (Gallery*)segue.destinationViewController;
            NSLog(@"ha%ld",(long)self.tattoomasterCell.clickindexpath.row);
            receiver.tattoomasterCell=_tattoomasterCell;
            
            [self.tableView deselectRowAtIndexPath:self.tattoomasterCell.clickindexpath animated:NO];
        }
    }

}


- (IBAction)favButton:(id)sender {
      if ([PFUser currentUser]) {
          
  UIButton* button = sender;
    CGPoint correctedPoint =
    [button convertPoint:button.bounds.origin toView:self.tableView];
   NSIndexPath* indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
          object = [imageFilesArray objectAtIndex:indexPath.row];
          imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    lastClickedRow = indexPath.row;
    object = [imageFilesArray objectAtIndex:indexPath.row];
          NSLog(@"%@",imageFilesArray);
          
          
          if ([[object objectForKey:@"favorites"]containsObject:[PFUser currentUser].objectId]) {
              
              [self dislike];
              
              NSLog(@"disliked");
                self.fav_image.image =[UIImage imageNamed:@"unlike.png"];

          }
          
          else{
              
              
              [self likeImage];
              
              NSLog(@"liked");
  self.fav_image.image =[UIImage imageNamed:@"like.png"];

                        }
      }
      else{
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未登入"
                                                          message:@"需要進入登入頁嗎？"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"確定",nil];
          //然后这里设定关联，此处把indexPath关联到alert上
          
          [alert show];

          NSLog(@"請登入")
          ; }
    [self.tableView reloadData];
}


- (IBAction)bookmarkbtn:(id)sender {
    if ([PFUser currentUser]) {
        
        UIButton* button = sender;
        CGPoint correctedPoint =
        [button convertPoint:button.bounds.origin toView:self.tableView];
        NSIndexPath* indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
        object = [imageFilesArray objectAtIndex:indexPath.row];
        imageObject = [imageFilesArray objectAtIndex:indexPath.row];
        lastClickedRow = indexPath.row;
        object = [imageFilesArray objectAtIndex:indexPath.row];
        NSLog(@"%@",imageFilesArray);
        
        
        if ([[object objectForKey:@"bookmark"]containsObject:[PFUser currentUser].objectId]) {
            
            [self nobookmark];
            
            NSLog(@"disliked");
            self.bookmark_image.image =[UIImage imageNamed:@"icon-favorite_2.png"];
            
        }
        
        else{
            
            
            [self bookmark];
            
            NSLog(@"liked");
            self.bookmark_image.image =[UIImage imageNamed:@"icon-favorite_onn.png"];
            
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未登入"
                                                        message:@"需要進入登入頁嗎？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"確定",nil];
        //然后这里设定关联，此处把indexPath关联到alert上
        
        [alert show];

        NSLog(@"請登入")
        ; }
    [self.tableView reloadData];
}
- (void) bookmark {
    
    [object addUniqueObject:[PFUser currentUser].objectId forKey:@"bookmark"];

    [object saveInBackground];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            //[self likedSuccess];
            self.isbookmark = YES;
        }
        else {
            [self bookmarkFail];
        }
    }];
}
- (void) nobookmark {
    [object removeObject:[PFUser currentUser].objectId forKey:@"bookmark"];
    [object saveInBackground];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            // [self dislikedSuccess];
            self.isbookmark = NO;
            
        }
        else {
            [self nobookmarkFail];
        }
    }];
}
- (void) nobookmarkSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"已經取消我的最愛" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) nobookmarkFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooops!" message:@"失敗" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) bookmarkSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"已經成功加入我的最愛" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) bookmarkFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooops!" message:@"失敗" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (IBAction)showsearch:(id)sender {
    [_detailsearchbar becomeFirstResponder];}
@end
