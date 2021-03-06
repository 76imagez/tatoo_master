//
//  news_detail_ViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 5/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import "SWRevealViewController.h"
#import "news_detail_ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface news_detail_ViewController ()
{
    // Inline
    MPMoviePlayerController *_player;
    
    // Player in new view
    //MPMoviePlayerViewController *_newViewPlayer;
}
@end

@implementation news_detail_ViewController

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
     [self queryParseMethod_2];
       UIFont *font_name = [UIFont fontWithName:@"Weibei TC" size:20];
    UIFont *font_count = [UIFont fontWithName:@"Weibei TC" size:15];
    UIFont *font_detail= [UIFont fontWithName:@"Weibei TC" size:15];

    NSDictionary *dimensions = @{ @"name":self.tattoomasterCell.name};
    [PFAnalytics trackEvent:@"show_detai_news" dimensions:dimensions];
    _news_detail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
      _news_detail.layer.cornerRadius=8.0f;
     _news_detail.layer.borderWidth=1.0f;
     _news_detail.layer.borderColor =[[UIColor grayColor] CGColor];
    //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.view.backgroundColor =[UIColor blackColor];
    CGRect frame =   _news_detail.frame;
    frame.size.height =  _news_detail.contentSize.height;
    _news_detail.frame = frame;
    _news_detail.font=font_detail;
    [  _news_detail sizeToFit];
    [self.news_detail setScrollEnabled:YES];
    _view_count.font=font_count;
    if (self.tattoomasterCell.news_view ==nil) {
        self.view_count.text = @"1";
    }
    else{
        self.view_count.text =[NSString stringWithFormat:@"%lu",(unsigned long)self.tattoomasterCell.news_view.count];
    }
    self.name.text =self.tattoomasterCell.name;
    self.name.font=font_name;
    _news_detail.text=self.tattoomasterCell.news;
    self.profile_image.file=self.tattoomasterCell.imageFile;
    self.profile_image.layer.cornerRadius =self.profile_image.frame.size.width / 2;
    self.profile_image.layer.borderWidth = 0.0f;
    self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profile_image.clipsToBounds = YES;
    
    // Code that executes when user taps Play
  //  NSURL *videoStreamURL = [NSURL URLWithString:@"http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"];
    
    // Create movie player object and add it to the view
    //_player = [[MPMoviePlayerController alloc] initWithContentURL:videoStreamURL];
    //_player.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 320);
    //[self.view addSubview:_player.view];
    
    // Play the stream
    //[_player play];
}
- (void)viewWillAppear:(BOOL)animated {
    // self.screenName = @"Main";
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    // self.page.numberOfPages = [imageFilesArray count];
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
                
                _profile_image.file =[object objectForKey:@"image"];
                [_profile_image.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    // self.profileimage.file=self.tattoomasterCell.imageFile;
                    self.profile_image.layer.cornerRadius =self.profile_image.frame.size.width / 2;
                    self.profile_image.layer.borderWidth = 0.0f;
                    self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
                    self.profile_image.clipsToBounds = YES;
                    
                    _profile_image.image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    _profile_image.image = [UIImage imageWithData:data];
                }];
            }}
    }];
    
    
}

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
