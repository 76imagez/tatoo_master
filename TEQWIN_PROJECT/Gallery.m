//
//  Gallery.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 16/9/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
#import "MBProgressHUD.h"
#import "Line.h"
#import "LKLineActivity.h"
#import "GalleryCell.h"
#import "Gallery.h"
#import "Tattoo_Detail_ViewController.h"
#import "TattooMasterCell.h"
#import "SWRevealViewController.h"
#import "CFShareCircleView.h"
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import  <ParseFacebookUtils/PFFacebookUtils.h>
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
typedef NS_ENUM(NSInteger, LKLineActivityImageSharingType) {
    LKLineActivityImageSharingDirectType,
    LKLineActivityImageSharingActivityType
};
@interface Gallery ()<UIScrollViewDelegate,CFShareCircleViewDelegate>

{
    
    TattooMasterCell *tattoomasterCell;
CFShareCircleView *shareCircleView;
    CGRect frame_first;
    UIImageView *fullImageView;
     int lastClickedRow;
}
@property (nonatomic, assign) LKLineActivityImageSharingType imageSharingType;
@end

@implementation Gallery
+ (UIPasteboard *)pasteboard {
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        return [UIPasteboard generalPasteboard];
    } else {
        return [UIPasteboard pasteboardWithName:@"jp.naver.linecamera.pasteboard" create:YES];
    }
}
@synthesize tableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
      imgStartWidth=fullImageView.frame.size.width;
	imgStartHeight=fullImageView.frame.size.height;
    NSDictionary *dimensions = @{ @"name":self.tattoomasterCell.name};
    [PFAnalytics trackEvent:@"showgallery" dimensions:dimensions];

    
   
    [self queryParseMethod];
 [self queryParseMethod_2];
   

    self.master_name.text=self.tattoomasterCell.name    ;
    self.title=@"作品庫";
    self.tableView.bounces=NO;
    // Create array object and assign it to _feedItems variable
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationController.navigationBar.translucent = NO;
    shareCircleView = [[CFShareCircleView alloc] initWithFrame:self.view.frame];
    shareCircleView.delegate = self;
    [self.navigationController.view addSubview:shareCircleView];
    }
- (BOOL)checkIfLineInstalled {
    BOOL isInstalled = [Line isLineInstalled];
    
    if (!isInstalled) {
        [[[UIAlertView alloc] initWithTitle:@"Line is not installed." message:@"Please download Line from App Store, and try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    return isInstalled;
}
- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
   
    NSLog(@"pkpk%@",self.profileimage.file);
         // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    if (self.tattoomasterCell.clickindexpath!=nil) {
        NSIndexPath *indexPat = [NSIndexPath indexPathForRow:self.tattoomasterCell.clickindexpath.row inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionMiddle animated:YES   ];}
    

    
    else{
      }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)queryParseMethod_2 {
    NSLog(@"start query");
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tattoo_Master"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [query whereKey:@"Master_id" equalTo:self.tattoomasterCell.master_id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            
        }
        if (!error) {
            NSArray * array;
            array = [[NSArray alloc] initWithArray:objects];
            for (PFObject *object in objects) {
                
                _profileimage.file =[object objectForKey:@"image"];
                [_profileimage.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                   // self.profileimage.file=self.tattoomasterCell.imageFile;
                    self.profileimage.layer.cornerRadius =self.profileimage.frame.size.width / 2;
                    self.profileimage.layer.borderWidth = 0.0f;
                    self.profileimage.layer.borderColor = [UIColor whiteColor].CGColor;
                    self.profileimage.clipsToBounds = YES;

                    _profileimage.image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    _profileimage.image = [UIImage imageWithData:data];
                }];
            }}
    }];
    
    
}

- (void)queryParseMethod {
    NSLog(@"start query");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];

    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
          [query orderByAscending:@"createdAt"];
    [query whereKey:@"Master_id" equalTo:self.tattoomasterCell.master_id];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
            if (imageFilesArray.count==0) {
                [self noimage];
                
            }
            [tableView reloadData];
            [hud hide:YES];
            
            
      
            
        }
        
    }];
    
}
#pragma mark - Table view data source
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *button = [alertView buttonTitleAtIndex:buttonIndex];
    if([button isEqualToString:@"確定"])
        
    {
        Tattoo_Detail_ViewController *galleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Tattoo_Detail_ViewController"];
        [self.navigationController pushViewController:galleryVC animated:YES];
        galleryVC.tattoomasterCell=_tattoomasterCell;
        ;

        
    }}
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
NSLog(@"%@", imageFilesArray);
}
- (void) noimage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"對不起" message:@"沒有照片" delegate:self cancelButtonTitle:@"確定" otherButtonTitles: nil];
    [alert show];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *CellIdentifier = @"parallaxCell";
    GalleryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    
    imageFile = [imageObject objectForKey:@"image"];
    
    cell.loadingSpinner.hidden = NO;
    [cell.loadingSpinner startAnimating];
      cell.image.image = [UIImage imageNamed:@"load1.png"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        cell.image.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        cell.image.layer.borderWidth=1.0;
         cell.image.layer.masksToBounds = YES;
       // cell.image.layer.borderColor=[[UIColor colorWithRed:176.0/255.0
                                    //                 green:147.0/255.0 blue:78/255.0 alpha:1.0]CGColor];
        cell.image.layer.borderColor=[[UIColor grayColor]CGColor];
            cell.image.image = [UIImage imageWithData:data];
        [cell.loadingSpinner stopAnimating];
        cell.loadingSpinner.hidden = YES;
    }];
     cell.image.tag=9999;
    cell.image.userInteractionEnabled=YES;
    [ cell.image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigButtonTapped:)]];
    
    image_desc = (UILabel*) [cell viewWithTag:199];
      UIFont *cellFont = [UIFont fontWithName:@"Weibei TC" size:12.0];
    image_desc.font=cellFont;
    if ([imageObject objectForKey:@"image_desc"] ==nil ||[[imageObject objectForKey:@"image_desc"]  isEqual:@""] ) {
        image_desc.text = @"　　";
    }
    else{
        image_desc.text= [imageObject objectForKey:@"image_desc"];
    }


    
        return cell;
}

-(void)pinch:(UIPinchGestureRecognizer *)sender{
    static CGPoint center;
    static CGSize initialSize;
    
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        center = sender.view.center;
        initialSize = sender.view.frame.size;
    }
    
    // scale the image
    sender.view.frame = CGRectMake(0,
                                   0,
                                   initialSize.width * sender.scale,
                                   initialSize.height * sender.scale);
    // recenter it with the new dimensions
    sender.view.center = center;}

//按圖第一下放大至fullscreen
-(void)actionTap:(UITapGestureRecognizer *)sender{
    NSLog(@"按一下返回");
    isshow=YES;
       CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath  = [self.tableView indexPathForRowAtPoint:location];
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView  cellForRowAtIndexPath:indexPath];
    PFObject *descobject = [imageFilesArray objectAtIndex:indexPath.row];
    
    
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:9999];
    
  test =[[UITextView alloc] initWithFrame:CGRectMake(0,  self.view.frame.size.height-44, 320,400)];
   // [test setBackgroundColor:[UIColor clearColor]];
    test.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];;
    test.textColor=[UIColor whiteColor];
      UIFont *cellFont = [UIFont fontWithName:@"Weibei TC" size:14.0];
    test.text= [descobject objectForKey:@"image_desc"];
    test.font=cellFont;
    CGRect frame =  test.frame;
    frame.size.height =  test.contentSize.height;
    test.frame = frame;
    test.editable=NO;
    [ test sizeToFit];
    NSLog(@"%f",test.frame.origin.y );
    
    frame_first=CGRectMake(cell.frame.origin.x+imageView.frame.origin.x,self.view.frame.size.height, imageView.frame.size.width, imageView.frame.size.height);
    
    fullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    fullImageView.backgroundColor=[UIColor blackColor];
    fullImageView.userInteractionEnabled=YES;
    [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap2:)]];
     [fullImageView addGestureRecognizer:[[UIPinchGestureRecognizer  alloc] initWithTarget:self action:@selector(pinch:)]];
    
      UIFont *buttonfont = [UIFont fontWithName:@"Weibei TC" size:14.0];
    [button.titleLabel setFont:buttonfont];
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect]; //3
       [button setTitle:@"Close" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonclose:) forControlEvents:UIControlEventTouchUpInside];//2
   //1
    
    
    fullImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    if (![fullImageView superview]) {
        
        fullImageView.image=imageView.image;
        
        [self.view.window addSubview:fullImageView];
         [self.view.window addSubview:test];
        [self.view.window addSubview:button];
        
        test.frame=frame_first;
        fullImageView.frame=frame_first;
        [UIView animateWithDuration:0.5 animations:^{
            
            fullImageView.frame=CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
        
            UIImage *home_news = [[UIImage imageNamed:@"dismiss_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *home_newsTap = [[UIImage imageNamed:@"dismiss_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [button setImage:home_news forState:UIControlStateNormal];
            [button setImage:home_newsTap forState:UIControlStateHighlighted];

button.frame=CGRectMake(250, 30, 50,50);
            test.frame=CGRectMake(0, self.view.frame.size.height-44, 320,test.contentSize.height);
         ;
           
            twoFingerPinch = [[UIPinchGestureRecognizer alloc]
                              initWithTarget:self
                              action:@selector(twoFingerPinch:)];
            [fullImageView addGestureRecognizer:twoFingerPinch];
        } completion:^(BOOL finished) {
            
            [UIApplication sharedApplication].statusBarHidden=YES;
            
        }];
        
    }
    
}

- (void)bigButtonTapped:(id)sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath  = [self.tableView indexPathForRowAtPoint:location];
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView  cellForRowAtIndexPath:indexPath];
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:9999];
    // Create image info
       fullImageView.image=imageView.image;
    
    
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = imageView.image;
  //  imageInfo.image =[UIImage imageNamed:@"login.png"];
    imageInfo.referenceRect = imageView.frame;
    imageInfo.referenceView = imageView.superview;
    imageInfo.referenceContentMode = imageView.contentMode;
    imageInfo.referenceCornerRadius = imageView.layer.cornerRadius;
    
    
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

////按圖第二下縮回原型
-(void)actionTap2:(UITapGestureRecognizer *)sender{
           if (isshow==YES) {
               [UIView animateWithDuration:0.5 animations:^{
                   
                   test.frame=frame_first;
                   
                   [test removeFromSuperview];
               } completion:^(BOOL finished) {
                   
                   [test removeFromSuperview];
               }];    [UIApplication sharedApplication].statusBarHidden=NO;
               
               isshow=NO;

        }
    else
    {
                 test.frame= CGRectMake(0,  self.view.frame.size.height-44, 320,400);
        test.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];;
                [self.view.window addSubview:test];

        isshow=YES;
    }
}
-(void)buttonclose:(UITapGestureRecognizer *)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        fullImageView.frame=frame_first;
        test.frame=frame_first;
         button.hidden=YES;
    } completion:^(BOOL finished) {
                [fullImageView removeFromSuperview];
        [test removeFromSuperview];
    }];
    
    [UIApplication sharedApplication].statusBarHidden=NO;
    
}




- (IBAction)btn_share:(id)sender {
   // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   // hud.mode = MBProgressHUDModeIndeterminate;
   // hud.labelText = @"Loading";
  
    UIButton *button = sender;
    CGPoint correctedPoint =
    [button convertPoint:button.bounds.origin toView:self.tableView];
    NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
    
    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    
   shareimageFile = [imageObject objectForKey:@"image"];
    image_desc =[imageObject objectForKey:@"image_desc"];
    [shareimageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
           imageToShare = [UIImage imageWithData:data];
 
    }];
    lastClickedRow = indexPath.row;
   


  
    [shareCircleView show];
    

}

- (IBAction)like:(id)sender {
    FBLikeControl * like =[[FBLikeControl alloc]init];
    like.objectID = @"http://shareitexampleapp.parseapp.com/photo1/";
    
}


- (void)shareCircleView:(CFShareCircleView *)aShareCircleView didSelectSharer:(CFSharer *)sharer{
   
    if ([sharer.name isEqual:@"Facebook"]) {
     
            // FALLBACK: publish just a link using the Feed dialog
            
            // Put together the dialog parameters
           // NSString *picURLstring =
            //[NSString stringWithFormat:@"http://files.parsetfss.com/c6afcb1f-6a07-4487-8d0d-8406c9b9f69c/tfss-0366ca1a-894e-45c2-b43b-f45b82d10f6a-gallery_02_5.jpg"] ;

            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           self.tattoomasterCell.name, @"name",
                                           @"TEQWIN SOLUTION", @"caption",
                                          image_desc, @"description",
                                           shareimageFile.url, @"link",
                                           shareimageFile.url,@"picture",
                                           nil];
            // Show the feed dialog
            [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                                   parameters:params
                                                      handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                          if (error) {
                                                              // An error occurred, we need to handle the error
                                                              // See: https://developers.facebook.com/docs/ios/errors
                                                              NSLog(@"Error publishing story: %@", error.description);
                                                          } else {
                                                              if (result == FBWebDialogResultDialogNotCompleted) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                              } else {
                                                                  // Handle the publish feed callback
                                                                  NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                                  
                                                                  if (![urlParams valueForKey:@"post_id"]) {
                                                                      // User canceled.
                                                                      NSLog(@"User cancelled.");
                                                                      
                                                                  } else {
                                                                      // User clicked the Share button
                                                                      NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                      NSLog(@"result %@", result);
                                                                  }
                                                              }
                                                          }
                                                      }];
        }
    if ([sharer.name isEqual:@"Twitter"]) {
        // 判斷社群網站的服務是否可用
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            
            // 建立對應社群網站的ComposeViewController
            SLComposeViewController *mySocialComposeView = [[SLComposeViewController alloc] init];
            mySocialComposeView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            // 插入文字
            [mySocialComposeView setInitialText:self.tattoomasterCell.name];
            
            // 插入網址
            // NSURL *myURL = [[NSURL alloc] initWithString:@"http://cg2010studio.wordpress.com/"];
            // [mySocialComposeView addURL: myURL];
            
            // 插入圖片
            
            NSString *picURLstring = [NSString stringWithFormat:@"https://localhost:443/phpMyAdmin/fyp_php/gallery_0%@_%d.jpg",[self.tattoomasterCell valueForKey:@"master_id"],lastClickedRow+1] ;
            
            NSURL *picURL = [NSURL URLWithString:picURLstring] ;
            
            UIImage *Slide = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:picURL]];
            
            UIImage *myImage = Slide;
            [mySocialComposeView addImage:myImage];
            
            
            // 呼叫建立的SocialComposeView
            [self presentViewController:mySocialComposeView animated:YES completion:^{
                NSLog(@"成功呼叫 SocialComposeView");
            }];
            
            // 訊息成功送出與否的之後處理
            [mySocialComposeView setCompletionHandler:^(SLComposeViewControllerResult result){
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        NSLog(@"取消送出");
                        break;
                    case SLComposeViewControllerResultDone:
                        NSLog(@"完成送出");
                        break;
                    default:
                        NSLog(@"其他例外");
                        break;
                }
            }];
        }
        else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"請先在系統設定中登入推特帳號。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [av show];
        }
        
    }
     if ([sharer.name isEqual:@"more"]) {
        
       
         NSString *textToShare = self.tattoomasterCell.name;
         
         
        // imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://files.parsetfss.com/c6afcb1f-6a07-4487-8d0d-8406c9b9f69c/tfss-d8fda74a-c9ff-436b-ab3e-a3b3d5c3e9d9-davee_05.jpg"]]]];
       //  imageToShare =[UIImage imageNamed:@"twitter.png"];
         NSURL *urlToShare = [NSURL URLWithString:@""];
         
         NSArray *activityItems = @[image_desc, imageToShare, urlToShare];
       

         UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
     ;

         
         [self presentViewController:activityVC animated:TRUE completion:nil];
     }

    if ([sharer.name isEqual:@"Whatsapp"]) {
      
        if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
            
            UIImage     * iconImage = imageToShare;
            NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
            
            [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
            
            _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
            _documentInteractionController.UTI = @"net.whatsapp.image";
            _documentInteractionController.delegate = self;
            
            [_documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
            
            
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }}
        if ([sharer.name isEqual:@"sina_weibo"]) {
            NSLog(@"sina");
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
                
                // 建立對應社群網站的ComposeViewController
                SLComposeViewController *mySocialComposeView = [[SLComposeViewController alloc] init];
                mySocialComposeView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                
                // 插入文字
                [mySocialComposeView setInitialText:[NSString stringWithFormat:@"%@", image_desc]];
                
                // 插入網址
                // NSURL *myURL = [[NSURL alloc] initWithString:@"http://cg2010studio.wordpress.com/"];
                // [mySocialComposeView addURL: myURL];
                
                // 插入圖片
                
                [mySocialComposeView addImage:imageToShare];
                
                
                // 呼叫建立的SocialComposeView
                [self presentViewController:mySocialComposeView animated:YES completion:^{
                    NSLog(@"成功呼叫 SocialComposeView");
                }];
                
                // 訊息成功送出與否的之後處理
                [mySocialComposeView setCompletionHandler:^(SLComposeViewControllerResult result){
                    switch (result) {
                        case SLComposeViewControllerResultCancelled:
                            NSLog(@"取消送出");
                            break;
                        case SLComposeViewControllerResultDone:
                            NSLog(@"完成送出");
                            break;
                        default:
                            NSLog(@"其他例外");
                            break;
                    }
                }];
            }
            else {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"請先在系統設定中登入新浪微博帳號。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [av show];
            }
            
    }
    if ([sharer.name isEqual:@"twitter"]) {
        NSLog(@"twitter");
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            
            // 建立對應社群網站的ComposeViewController
            SLComposeViewController *mySocialComposeView = [[SLComposeViewController alloc] init];
            mySocialComposeView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            // 插入文字
            
            
            // 插入網址
            // NSURL *myURL = [[NSURL alloc] initWithString:@"http://cg2010studio.wordpress.com/"];
            // [mySocialComposeView addURL: myURL];
            
            // 插入圖片
            
            [mySocialComposeView addImage:imageToShare];
            
            
            // 呼叫建立的SocialComposeView
            [self presentViewController:mySocialComposeView animated:YES completion:^{
                NSLog(@"成功呼叫 SocialComposeView");
            }];
            
            // 訊息成功送出與否的之後處理
            [mySocialComposeView setCompletionHandler:^(SLComposeViewControllerResult result){
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        NSLog(@"取消送出");
                        break;
                    case SLComposeViewControllerResultDone:
                        NSLog(@"完成送出");
                        break;
                    default:
                        NSLog(@"其他例外");
                        break;
                }
            }];
        }
        else {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"請先在系統設定中登入Twitter帳號。" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [av show];
        }
        
    }
    if ([sharer.name isEqual:@"line"]) {
        //UIImage *image = imageToShare;
        
      //  UIPasteboard *pasteboard;
        
        //iOS7.0以降では共有のクリップボードしか使えない。その際クリップボードが上書きされてしまうので注意。
      //  if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
      //      pasteboard = [UIPasteboard generalPasteboard];
      //  } else {
      //      pasteboard = [UIPasteboard pasteboardWithUniqueName];
      //  }
        
       // [pasteboard setData:UIImagePNGRepresentation(image)
       //   forPasteboardType:@"public.png"];
        
       // NSString *LINEUrlString = [NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name];
        
        //LINEがインストールされているか確認。されていなければアラート→AppStoreを開く
       // if ([[UIApplication sharedApplication]
       //      canOpenURL:[NSURL URLWithString:LINEUrlString]]) {
       //     [[UIApplication sharedApplication]
       //      openURL:[NSURL URLWithString:LINEUrlString]];
       // } else {
       //     NSLog(@"fail");
       // }
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]]) {
            // do somethin
            UIPasteboard *pasteboard = [UIPasteboard pasteboardWithUniqueName];
            NSString *pasteboardName = pasteboard.name;
            NSURL *imageURL = [NSURL URLWithString:imageFile.url];
            [pasteboard setData:UIImagePNGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]]) forPasteboardType:@"public.png"];
            
            NSString *contentType = @"image";
            NSString *contentKey = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                        (CFStringRef)pasteboardName,
                                                                                                        NULL,
                                                                                                        CFSTR(":/?=,!$&'()*+;[]@#"),
                                                                                                        CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
            
            NSString *urlString = [NSString stringWithFormat:@"line://msg/%@/%@",
                                   contentType, contentKey];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        else{
            NSURL *itunesURL = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id443904275"];
            [[UIApplication sharedApplication] openURL:itunesURL];
        }
    }

    
    
        if ([sharer.name isEqual:@"wechat"]) {
        NSLog(@"33");
        CGRect rect = CGRectMake(0 ,0 , 0, 0);
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIGraphicsEndImageContext();
        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"http://media.line.me/img/button/ja/36x60.png"];
        
        NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", jpgPath]];
        _documentInteractionController.UTI = @"com.instagram.photo";
        _documentInteractionController = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
        _documentInteractionController=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
        [_documentInteractionController presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
    }

}
- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL
                                               usingDelegate: (id ) interactionDelegate {

    self.documentationInteractionController =
    
    [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    
    self.documentationInteractionController.delegate = interactionDelegate;
    
    return self.documentationInteractionController;
    
}- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

@end
