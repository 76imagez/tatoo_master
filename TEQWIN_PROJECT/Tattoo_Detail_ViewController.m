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
@interface Tattoo_Detail_ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    int lastClickedRow;
    CGRect frame_first;
    UIImageView *fullImageView;
    CGRect frame_collectionview;
    CGRect frame;
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
       UIFont *cellFont = [UIFont fontWithName:@"Weibei TC" size:12.0];
    self.description_textview.font=cellFont;
    self.description_textview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    
    if (self.tattoomasterCell.desc ==nil ||[self.tattoomasterCell.desc  isEqual:@""] ) {
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
     frame =  self.description_textview.frame;
    frame.size.height =  self.description_textview.contentSize.height;
    self.description_textview.frame = frame;
    [ self.description_textview sizeToFit];
    [self.description_textview setScrollEnabled:NO];
    [self.description_textview setEditable:NO];
       
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
    self.profileimage.layer.borderWidth = 1.0f;
    self.profileimage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileimage.clipsToBounds = YES;
    _tableView.bounces=YES;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.imagesCollection setCollectionViewLayout:flowLayout];
    flowLayout.itemSize = CGSizeMake(80, 80);
    [flowLayout setSectionInset:UIEdgeInsetsMake(15, 10, 10,50)];

    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // LIST
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
- (void)queryParseMethod {
    NSLog(@"start query");
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [query whereKey:@"Master_id" equalTo:self.tattoomasterCell.master_id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            
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
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query whereKey:@"Master_id" equalTo:self.tattoomasterCell.master_id];
    
   
      [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            if (objects.count ==0) {
               
                self.noimage.text = @"noimage";
            }

            else{

            imageFilesArray_image = [[NSArray alloc] initWithArray:objects];
           
                
                
                           self.noimage.text=@"";
              
            
            [_imagesCollection reloadData];
                
            }}}
     ];
    
}-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80 ,80);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imageFilesArray_image count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    frame_collectionview.size.height=111;
    
    static NSString *cellIdentifier = @"imageCell";
    ImageExampleCell *cell = (ImageExampleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    imageObject = [imageFilesArray_image objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"image"];
    
    cell.loadingSpinner.hidden = NO;
    [cell.loadingSpinner startAnimating];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            
            CGSize itemSize = CGSizeMake(80, 80);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [ cell.parseImage.image drawInRect:imageRect];
            cell.parseImage.layer.cornerRadius =cell.parseImage.frame.size.width / 2;
            cell.parseImage.layer.borderWidth = 1.0f;
           cell.parseImage.layer.borderColor = [UIColor whiteColor].CGColor;
           cell.parseImage.clipsToBounds = YES;
            cell.parseImage.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext() ;
            //  UIGraphicsEndImageContext();
            cell.parseImage.image = [UIImage imageWithData:data];
            [cell.loadingSpinner stopAnimating];
            cell.loadingSpinner.hidden = YES;


     
            rectangle = self.imagesCollection.frame;
            rectangle.size = [self.imagesCollection.collectionViewLayout collectionViewContentSize];
           
            self.imagesCollection.frame=rectangle;
          
          //   [ self.imagesCollection sizeToFit];
            
            
            if ([UIScreen mainScreen].bounds.size.height ==480) {
                [self.scrollView setContentSize:CGSizeMake(320,  +450+self.description_textview.contentSize.height+rectangle.size.height)];
              
                NSLog(@"rectangle%f",rectangle.size.height);
                 NSLog(@"frame%f",self.description_textview.contentSize.height);
                NSLog(@"%f",self.view.frame.size.height+400);
                
            }
            else
            {
                [self.scrollView setContentSize:CGSizeMake(320,  +350+ self.description_textview.contentSize.height+rectangle.size.height)];
                NSLog(@"rectangle%f",rectangle.size.height);
                NSLog(@"frame%f",self.description_textview.contentSize.height);
                NSLog(@"VIEW%f",self.view.frame.size.height+400);
 NSLog(@"%f",frame.size.height);
            }

        //    frame_collectionview.size=rectangle.size;
            
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
    UIFont *cellFont = [UIFont fontWithName:@"Weibei TC" size:17.0];
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
    return rect.size.height + 10;
    
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.tableView.contentSize = CGSizeMake(self.tableView.frame.size.width,999);//(phoneCellHeight*phoneList.count)
    
    
    static NSString *identifier =@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
       NSLog(@"aaaa%f",self.tableView.contentSize.height);
    
    
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
                if ([self.tattoomasterCell.address isEqual:@""]) {
                    cell.detailTextLabel.textColor =[UIColor colorWithRed:30.0/256.0 green:30.0/256.0 blue:30.0/256.0 alpha:1 ];
                }
                else
                {
                    
                }
                
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
                if ([self.tattoomasterCell.website isEqual:@""]) {
                    cell.detailTextLabel.textColor =[UIColor colorWithRed:30.0/256.0 green:30.0/256.0 blue:30.0/256.0 alpha:1 ];
                }
                else
                {
                    
                }
                
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
                if ([self.tattoomasterCell.email isEqual:@""]) {
                    cell.detailTextLabel.textColor =[UIColor colorWithRed:30.0/256.0 green:30.0/256.0 blue:30.0/256.0 alpha:1 ];
                }
                else
                {
                    
                }
                
                
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
                if ([self.tattoomasterCell.tel isEqual:@""]) {
                    cell.detailTextLabel.textColor =[UIColor colorWithRed:30.0/256.0 green:30.0/256.0 blue:30.0/256.0 alpha:1 ];
                }
                else
                {
                    
                }
                
                
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
        cell.textLabel.font = [UIFont fontWithName:@"Weibei TC" size:14];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Weibei TC" size:14];
        
        cell.contentView.backgroundColor = [UIColor blackColor];
        
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //cell.backgroundColor =[UIColor clearColor];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor =  [[UIColor colorWithRed:85.0/256.0 green:85.0/256.0 blue:85.0/256.0 alpha:1 ]colorWithAlphaComponent:0.5f];
    [cell setSelectedBackgroundView:bgColorView];
    
    
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
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10; // This is the minimum inter item spacing, can be more
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
                if ([self.tattoomasterCell.address  isEqual:@""]) {
                    NSLog(@"disabled");
                    
                }
                else{
                    
                    Map_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Map_ViewController"];
                    [self.navigationController pushViewController:mapVC animated:YES];
                    mapVC.tattoomasterCell=_tattoomasterCell;
                    NSLog(@"%@%@",self.tattoomasterCell.latitude,self.tattoomasterCell.longitude);
                }}
                break;
            case 1:{
                if ([self.tattoomasterCell.website  isEqual:@""]) {
                    NSLog(@"disabled");
                    
                }
                else{
                    
                    NSURL *url = [NSURL URLWithString:self.tattoomasterCell.website ];
                    [[UIApplication sharedApplication] openURL:url];
                }}
                break;
            case 2:
                //Create the MailComposeViewController
                
            {
                if ([self.tattoomasterCell.email  isEqual:@""]) {
                    NSLog(@"disabled");
                    
                }
                else{
                    
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
                }}
                break;
                
                //make alert box and phonecall function
            case 3:
                
            {
                if ([self.tattoomasterCell.tel  isEqual:@""]) {
                    NSLog(@"disabled");
                    
                }
                else{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"撥號"
                                                                    message:@"確定要撥號嗎？"
                                                                   delegate:self
                                                          cancelButtonTitle:@"否"
                                                          otherButtonTitles:@"是",nil];
                    //然后这里设定关联，此处把indexPath关联到alert上
                    
                    [alert show];
                    
                }
                
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
        NSLog(@"11");
        
        if ([segue.destinationViewController isKindOfClass:[Gallery class]]){
            NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
            Gallery *receiver = (Gallery*)segue.destinationViewController;
            receiver.tattoomasterCell=_tattoomasterCell;
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
           
        }
    }
    if ([segue.identifier isEqualToString:@"GOGALLERY_collection"]) {
          NSLog(@"22");
        
        if ([segue.destinationViewController isKindOfClass:[Gallery class]]){
            self.tattoomasterCell.clickindexpath = [self.imagesCollection indexPathForCell:sender];
            Gallery *receiver = (Gallery*)segue.destinationViewController;
            NSLog(@"ha%ld",(long)self.tattoomasterCell.clickindexpath.row);
            receiver.tattoomasterCell=_tattoomasterCell;
            receiver.tattoomasterCell.imageFile =_tattoomasterCell.imageFile;
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
