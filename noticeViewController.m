//
//  noticeViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 6/10/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import <Parse/Parse.h>
#import "noticeViewController.h"
#import "SWRevealViewController.h"
@interface noticeViewController ()

@end

@implementation noticeViewController

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
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    [super viewDidLoad];
    NSDictionary *dimensions = @{ @"Notice":@"Muay_Notice"};
    [PFAnalytics trackEvent:@"show_Notice" dimensions:dimensions];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textview_1.text=@"第一、刺青之後的三到五個小時之內，用溫水來清洗身體，把表面多餘的顏料或者是滲出的血液擦去，請記住，這一個步驟十分重要，如果時間過早，則會容易讓皮膚下層的顏料淡化，如果時間過長，滲出的血液不容易擦掉，而且以後每天要注意清洗，保持皮膚的乾淨和清潔，這樣會讓刺青的顏色起到很好的保護。";
    self.textview_1.layer.cornerRadius=8.0f;
    self.textview_1.layer.borderWidth=2.0;
    self.textview_1.layer.borderColor =[[UIColor grayColor] CGColor];
    CGRect frame =  self.textview_1.frame;
    frame.size.height =  self.textview_1.contentSize.height;
    self.textview_1.frame = frame;
    [ self.textview_1 sizeToFit];
    [self.textview_1 setScrollEnabled:YES];
    
    self.textview_2.text=@"第二、不要使用任何的藥品或者藥膏來塗抹，有一些人往往擔心自己的皮膚出現感染或者其他的證狀，所以就會自主的使用一些藥膏來塗抹，因爲有化學成分的一些藥膏會對於刺青的顏色形成一定的傷害，最後破壞掉整體的美觀性。";
    self.textview_2.layer.cornerRadius=8.0f;
    self.textview_2.layer.borderWidth=2.0;
    self.textview_2.layer.borderColor =[[UIColor grayColor] CGColor];
    CGRect frame2 =  self.textview_2.frame;
    frame2.size.height =  self.textview_2.contentSize.height;
    self.textview_2.frame = frame2;
    [ self.textview_2 sizeToFit];
    [self.textview_2 setScrollEnabled:YES];

    self.textview_3.text=@"第三、不能在刺青之後的一個星期之內進行長時間浸水的接觸，比如泡澡、桑拿等等，這個時候，皮膚下面的的色素還沒有完全固定，容易隨著水的滲入而產生變化，另外也不可以曬太陽。";
    self.textview_3.layer.cornerRadius=8.0f;
    self.textview_3.layer.borderWidth=2.0;
    self.textview_3.layer.borderColor =[[UIColor grayColor] CGColor];
    CGRect frame3 =  self.textview_3.frame;
    frame3.size.height =  self.textview_3.contentSize.height;
    self.textview_3.frame = frame3;
    [ self.textview_3 sizeToFit];
    [self.textview_3 setScrollEnabled:YES];

    self.textview_4.text=@"第四、不可對皮膚任何的抓撓行爲，有些人的皮膚往往會在刺青之後的三到四天之內，出現癢的現象，請不要擔心，這是皮膚的正常反應，一般兩天之後就會消失，一定不能抓，也不能撓。";
    self.textview_4.layer.cornerRadius=8.0f;
    self.textview_4.layer.borderWidth=2.0;
    self.textview_4.layer.borderColor =[[UIColor grayColor] CGColor];
    CGRect frame4 =  self.textview_4.frame;
    frame4.size.height =  self.textview_4.contentSize.height;
    self.textview_4.frame = frame4;
    [ self.textview_4 sizeToFit];
    [self.textview_4 setScrollEnabled:YES];

    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];

    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.title =@"紋身注意事項";
}

- (void)viewWillAppear:(BOOL)animated {
  
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textview_1.text=@"第一、刺青之後的三到五個小時之內，用溫水來清洗身體，把表面多餘的顏料或者是滲出的血液擦去，請記住，這一個步驟十分重要，如果時間過早，則會容易讓皮膚下層的顏料淡化，如果時間過長，滲出的血液不容易擦掉，而且以後每天要注意清洗，保持皮膚的乾淨和清潔，這樣會讓刺青的顏色起到很好的保護。";
    self.textview_1.layer.cornerRadius=8.0f;
    self.textview_1.layer.borderWidth=2.0;
    self.textview_1.layer.borderColor =[[UIColor colorWithRed:150.0/255.0
                                                        green:150.0/255.0
                                                         blue:150.0/255.0
                                                        alpha:1.0] CGColor];
    CGRect frame =  self.textview_1.frame;
    frame.size.height =  self.textview_1.contentSize.height;
    self.textview_1.frame = frame;
    [ self.textview_1 sizeToFit];
    [self.textview_1 setScrollEnabled:YES];
    
    self.textview_2.text=@"第二、不要使用任何的藥品或者藥膏來塗抹，有一些人往往擔心自己的皮膚出現感染或者其他的證狀，所以就會自主的使用一些藥膏來塗抹，因爲有化學成分的一些藥膏會對於刺青的顏色形成一定的傷害，最後破壞掉整體的美觀性。";
    self.textview_2.layer.cornerRadius=8.0f;
    self.textview_2.layer.borderWidth=2.0;
    self.textview_2.layer.borderColor =[[UIColor colorWithRed:171.0/255.0
                                                       green:171.0/255.0
                                                        blue:171.0/255.0
                                                       alpha:1.0] CGColor];
    CGRect frame2 =  self.textview_2.frame;
    frame2.size.height =  self.textview_2.contentSize.height;
    self.textview_2.frame = frame2;
    [ self.textview_2 sizeToFit];
    [self.textview_2 setScrollEnabled:YES];
    
    self.textview_3.text=@"第三、不能在刺青之後的一個星期之內進行長時間浸水的接觸，比如泡澡、桑拿等等，這個時候，皮膚下面的的色素還沒有完全固定，容易隨著水的滲入而產生變化，另外也不可以曬太陽。";
    self.textview_3.layer.cornerRadius=8.0f;
    self.textview_3.layer.borderWidth=2.0;
    self.textview_3.layer.borderColor =[[UIColor colorWithRed:200.0/255.0
                                                        green:200.0/255.0
                                                         blue:200.0/255.0
                                                        alpha:1.0] CGColor];

    CGRect frame3 =  self.textview_3.frame;
    frame3.size.height =  self.textview_3.contentSize.height;
    self.textview_3.frame = frame3;
    [ self.textview_3 sizeToFit];
    [self.textview_3 setScrollEnabled:YES];
    
    self.textview_4.text=@"第四、不可對皮膚任何的抓撓行爲，有些人的皮膚往往會在刺青之後的三到四天之內，出現癢的現象，請不要擔心，這是皮膚的正常反應，一般兩天之後就會消失，一定不能抓，也不能撓。";
    self.textview_4.layer.cornerRadius=8.0f;
    self.textview_4.layer.borderWidth=2.0;
    self.textview_4.layer.borderColor =[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0].CGColor;

    CGRect frame4 =  self.textview_4.frame;
    frame4.size.height =  self.textview_4.contentSize.height;
    self.textview_4.frame = frame4;
    [ self.textview_4 sizeToFit];
    [self.textview_4 setScrollEnabled:YES];
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];

    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.title =@"紋身注意事項";

   }

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
