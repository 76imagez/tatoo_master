//
//  LoginUIViewController.m
//  FBLoginUIControlSample
//
//  Created by Luz Caballero on 9/17/13.
//  Copyright (c) 2013 Facebook Inc. All rights reserved.
//

/* This sample implements Login with Facebook using the standard Login button. 
 It asks for the public_profile, email and user_likes permissions.
 You can see the tutorial that accompanies this sample here:
 https://developers.facebook.com/docs/ios/login-tutorial/#login-button
 
 For simplicity, this sample does limited error handling. You can read more
 about handling errors in our Error Handling guide:
 https://developers.facebook.com/docs/ios/errors
*/
#import "Gallery.h"
#import "MBProgressHUD.h"
#import "Tattoo_Detail_ViewController.h"
#import "Tattoo_Master_Info.h"
#import "TattooMaster_ViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "LoginUIViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
#import "MainViewController.h"

@interface LoginUIViewController ()

{
    int lastClickedRow;
}

@end

@implementation LoginUIViewController
@synthesize TABLEVIEW;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    self.view.backgroundColor=[UIColor grayColor];
UIFont *yourCustomFont = [UIFont fontWithName:@"叶根友千秋字体" size:18];
    _logout.titleLabel.font = yourCustomFont;
    
 
    

  
    
      _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);

    

    
    self.title=@"我的檔案";
    // Set the gesture
       if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
       
         logInViewController.fields = PFLogInFieldsFacebook | PFLogInFieldsDismissButton  ;
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        // Set the gesture
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

        [self presentViewController:logInViewController animated:YES completion:NULL];
           
    }
}
-(CGFloat) tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int hight=78.0f;
    
    return hight;
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor=[UIColor grayColor];
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        PFQuery *bookmarkquery = [PFQuery queryWithClassName:@"Tattoo_Master"];
        
        [bookmarkquery whereKey:@"bookmark" equalTo:[PFUser currentUser].objectId];
        
        
       // bookmarkquery.cachePolicy = kPFCachePolicyCacheThenNetwork;
        
        [bookmarkquery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if ([objects count] == 0) {
                bookmarkquery.cachePolicy = kPFCachePolicyCacheThenNetwork;
            }
            if (!error) {
                
                countarray = [[NSArray alloc] initWithArray:objects];
                self.bookmarks_count.text=[NSString stringWithFormat:@"%lu",(unsigned long)countarray.count];
                
            }
        }];
        PFQuery *likequery = [PFQuery queryWithClassName:@"Tattoo_Master"];
        
        [likequery whereKey:@"favorites" equalTo:[PFUser currentUser].objectId];
        
        
        likequery.cachePolicy = kPFCachePolicyCacheThenNetwork;
        
        [likequery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                countarray = [[NSArray alloc] initWithArray:objects];
                self.liked_count.text=[NSString stringWithFormat:@"%lu",(unsigned long)countarray.count];
                
                
            }
        }];
    }

    
    

    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    if ([PFUser currentUser]) {
        self.profile_image.layer.cornerRadius =self.profile_image.frame.size.width / 2;
        self.profile_image.layer.borderWidth = 3.0f;
        self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
        self.profile_image.clipsToBounds = YES;
        
        
        
        if ([PFTwitterUtils isLinkedWithUser:[PFUser currentUser]]) {
            // If user is linked to Twitter, we'll use their Twitter screen name
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"@%@!", nil), [PFTwitterUtils twitter].screenName];
            
            
            
            
        } else if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
            // If user is linked to Facebook, we'll use the Facebook Graph API to fetch their full name. But first, show a generic Welcome label.
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"", nil)];
            
            // Create Facebook Request for user's details
            FBRequest *request = [FBRequest requestForMe];
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                
                
                
                
                
                // handle response
                if (!error) {
                    // Parse the data received
                    NSDictionary *userData = (NSDictionary *)result;
                    
                    NSString *facebookID = userData[@"id"];
                    NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
                    if (facebookID) {
                        userProfile[@"facebookId"] = facebookID;
                    }
                    
                    NSString *name = userData[@"name"];
                    if (name) {
                        userProfile[@"name"] = name;
                    }
                    
                    userProfile[@"pictureURL"] = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
                    
                    [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
                    [[PFUser currentUser] saveInBackground];
                    [self _updateProfileData];
                    NSString *displayName = result[@"name"];
                    if (displayName) {
                        self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"%@", nil), name];
                    }
                }
            }];
            
        } else {
           
            // If user is linked to neither, let's use their username for the Welcome label.
            self.welcomeLabel.text =[NSString stringWithFormat:NSLocalizedString(@"歡迎 %@", nil), [PFUser currentUser].username];
            
        }
        
    }
   
}
// Set received values if they are not nil and reload the table
- (void)_updateProfileData {
    
    
    // Set the name in the header view label
    NSString *name = [PFUser currentUser][@"profile"][@"name"];
    if (name) {
             self.welcomeLabel.text = name;
    }
    
    NSString *userProfilePhotoURLString = [PFUser currentUser][@"profile"][@"pictureURL"];
    // Download the user's facebook profile picture
    if (userProfilePhotoURLString) {
        NSURL *pictureURL = [NSURL URLWithString:userProfilePhotoURLString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   if (connectionError == nil && data != nil) {
                                       self.profile_image.image = [UIImage imageWithData:data];
                                       
                                       // Add a nice corner radius to the image
                                       self.profile_image.layer.cornerRadius =self.profile_image.frame.size.width / 2;
                                       self.profile_image.layer.borderWidth = 3.0f;
                                       self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
                                       self.profile_image.clipsToBounds = YES;
                                   } else {
                                       NSLog(@"Failed to load profile photo.");
                                   }
                               }];
    }
}

- (void)queryParseMethod {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
 
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    
    [query whereKey:@"favorites" equalTo:[PFUser currentUser].objectId];
    
   
  //  query.cachePolicy = kPFCachePolicyCacheThenNetwork;
   
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
            
                            [TABLEVIEW reloadData];
          
            [hud hide:YES];
                  }
    }];
}
- (void)bookmark_query {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    
    [query whereKey:@"bookmark" equalTo:[PFUser currentUser].objectId];
    
    
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
           
            
            [TABLEVIEW reloadData];
            
            [hud hide:YES];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imageFilesArray count];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //lastClickedRow = indexPath.row;

   // selectobject = [imageFilesArray objectAtIndex:indexPath.row];
   // PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    
   

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"favcell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
      
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    // Configure the cell
    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    PFFile *thumbnail = [imageObject objectForKey:@"image"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    CGSize itemSize = CGSizeMake(70, 70);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    thumbnailImageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
    thumbnailImageView.layer.cornerRadius=8.0f;
    thumbnailImageView.layer.borderWidth=0.0;
    thumbnailImageView.layer.masksToBounds = YES;
    thumbnailImageView.layer.borderColor=[[UIColor whiteColor] CGColor];
    [thumbnailImageView.image drawInRect:imageRect];
    thumbnailImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    sex_statues = (PFImageView*)[cell viewWithTag:144];
    if ([[imageObject objectForKey:@"Gender"]isEqualToString:@"男"]) {
        
        
        sex_statues.image = [UIImage imageNamed:@"male.png"];
    }
    else
        if ([[imageObject objectForKey:@"Gender"]isEqualToString:@"女"]) {
            
            sex_statues.image = [UIImage imageNamed:@"female.png"];
        }

    UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
    nameLabel.text = [imageObject objectForKey:@"Name"];
    
    UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
    prepTimeLabel.text = [imageObject objectForKey:@"Gender"];
    
     PFImageView *fav = (PFImageView*)[cell viewWithTag:120];
      if ([[imageObject objectForKey:@"favorites"]containsObject:[PFUser currentUser].objectId]) {
    fav.image = [UIImage imageNamed:favstring];
      }
    else
    {
        fav.image = [UIImage imageNamed:favstring];
    }
    
    
    gallary_image = (PFImageView*)[cell viewWithTag:161];
    gallary_button = (UIButton*)[cell viewWithTag:162];
    
   
    if ([[imageObject objectForKey:@"gallary_displayallow"]isEqualToValue:[NSNumber numberWithBool:YES]]) {
        NSLog(@"%@",self.tattoomasterCell.master_id);
        gallary_image.image=[UIImage imageNamed:@"photo_on.png"];
        gallary_button.enabled=YES;
    }
    else
    {
        gallary_image.image = [UIImage imageNamed:@"photo.png"];
        ;
        gallary_button.enabled=NO;
        NSLog(@"%@",self.tattoomasterCell.master_id);

    }
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showfavdetail"]) {
        NSIndexPath *indexPath = [TABLEVIEW indexPathForSelectedRow];
        Tattoo_Detail_ViewController *destViewController = segue.destinationViewController;
        
        PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
        TattooMasterCell *tattoomasterCell = [[TattooMasterCell alloc] init];
        tattoomasterCell.name = [imageObject objectForKey:@"Name"];
        tattoomasterCell.favorites = [imageObject objectForKey:@"favorites"];
        tattoomasterCell.bookmark = [imageObject objectForKey:@"bookmark"];
        tattoomasterCell.imageFile = [imageObject objectForKey:@"image"];
        tattoomasterCell.gender = [imageObject objectForKey:@"Gender"];
        tattoomasterCell.tel = [imageObject objectForKey:@"Tel"];
        tattoomasterCell.email = [imageObject objectForKey:@"Email"];
        tattoomasterCell.address = [imageObject objectForKey:@"Address"];
        tattoomasterCell.latitude = [imageObject objectForKey:@"Latitude"];
        tattoomasterCell.longitude = [imageObject objectForKey:@"Longitude"];
        tattoomasterCell.website = [imageObject objectForKey:@"Website"];
        tattoomasterCell.personage = [imageObject objectForKey:@"Personage"];
        tattoomasterCell.master_id = [imageObject objectForKey:@"Master_id"];
        tattoomasterCell.imageFile = [imageObject objectForKey:@"image"];
        tattoomasterCell.gallery_m1 = [imageObject objectForKey:@"Gallery_M1"];
        tattoomasterCell.object_id = [imageObject objectForKey:@"objectId"];
            tattoomasterCell.desc = [imageObject objectForKey:@"description"];
        tattoomasterCell.view = [imageObject objectForKey:@"view"];
        destViewController.tattoomasterCell = tattoomasterCell;
           NSLog(@"%@444",tattoomasterCell.master_id);
    }
    if ([segue.identifier isEqualToString:@"GOGALLERY_PROFILE"]) {
        UIButton *button = sender;
        CGPoint correctedPoint =
        [button convertPoint:button.bounds.origin toView:self.TABLEVIEW];
        NSIndexPath *indexPath =  [self.TABLEVIEW indexPathForRowAtPoint:correctedPoint];
        Gallery *destViewController = segue.destinationViewController;
        
        PFObject *object = [imageFilesArray objectAtIndex:indexPath.row];
        TattooMasterCell *tattoomasterCell = [[TattooMasterCell alloc] init];
      //  tattoomasterCell.clickindexpath =[self.TABLEVIEW indexPathForRowAtPoint:correctedPoint];
        tattoomasterCell.clickindexpath =0;
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
        tattoomasterCell.imageFile = [object objectForKey:@"image"];
        tattoomasterCell.gallery_m1 = [object objectForKey:@"Gallery_M1"];
  
        tattoomasterCell.object_id = object.objectId;
        tattoomasterCell.desc=[object objectForKey:@"description"];
        destViewController.tattoomasterCell = tattoomasterCell;
        
        
        NSLog(@"%@333",tattoomasterCell.master_id);
        
    }

}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}




#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"] animated:YES];

}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - ()

- (IBAction)showlike:(id)sender {
     [self queryParseMethod];
    self.like.textColor=[UIColor grayColor];
    self.like_btn.image=[UIImage imageNamed:@"like.png"];
    self.bookmark.textColor=[UIColor whiteColor];
    self.bookmark_btn.image=[UIImage imageNamed:@"icon-favorite_2.png"];

}


- (IBAction)showbookmark:(id)sender {
       [self bookmark_query];
    self.like.textColor=[UIColor whiteColor];
     self.like_btn.image=[UIImage imageNamed:@"unlike.png"];
    self.bookmark.textColor=[UIColor grayColor];
   self.bookmark_btn.image=[UIImage imageNamed:@"icon-favorite_onn.png"];

}

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"] animated:YES];

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
     [self unlikeImage];
}

- (IBAction)Fav:(id)sender {
    UIButton *button = sender;
    CGPoint correctedPoint =
    [button convertPoint:button.bounds.origin toView:self.TABLEVIEW];
    NSIndexPath *indexPath =  [self.TABLEVIEW indexPathForRowAtPoint:correctedPoint];

   // NSLog(@"%ld",(long)button.tag);
   
     selectobject = [imageFilesArray objectAtIndex:indexPath.row];
   // NSLog(@"%@",selectobject);
    if ([[selectobject objectForKey:@"favorites"]containsObject:[PFUser currentUser].objectId]) {

  //  [self unlikeImage];
     
      }
    else
    {
    //     [self likeImage];

    }
    
}
- (void) likeImage {
    [selectobject addUniqueObject:[PFUser currentUser].objectId forKey:@"favorites"];
    [selectobject saveInBackground];
    [selectobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            [self likedSuccess];
            self.isFav = YES;
        }
        else {
            [self likedFail];
        }
    }];
}

- (void) unlikeImage {
    [selectobject removeObject:[PFUser currentUser].objectId forKey:@"favorites"];
    [selectobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"liked picture!");
            [self unlikedSuccess];
            
         
        }
        else {
            [self unlikedFail];
        }
    }];
}
- (void) likedSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You have succesfully liked the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void) likedFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooops!" message:@"There was an error when liking the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (void) unlikedSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功!" message:@"你已經取消了我的最愛" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    self.isFav = NO;
}

- (void) unlikedFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失敗!" message:@"There was an error when liking the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)GOGALLARY:(id)sender {
}
@end
