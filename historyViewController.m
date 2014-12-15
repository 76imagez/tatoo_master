//
//  historyViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 6/10/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import <Parse/Parse.h>
#import "historyViewController.h"
#import "SWRevealViewController.h"
@interface historyViewController ()

@end

@implementation historyViewController

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
    NSDictionary *dimensions = @{ @"Notice":@"Muay_History"};
    [PFAnalytics trackEvent:@"show_History" dimensions:dimensions];
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];

    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.title =@"紋身歷史";
    self.textview_1.text=@"刺青，又稱文身或紋身，指用有墨的針刺入皮膚底層而在皮膚上書畫出圖案或詞彙。商務印書館《現代漢語詞典》中对「紋身」的解釋為：“在人體上繪成或刺成帶顏色的花紋或圖形”。\n中國古代開始就有關於刺青的記載，《越絕書·外傳本事》記載：「越王句踐，東垂海濱，夷狄文身。」《墨子·公孟》：「越王句踐，剪髮文身。」《左傳·哀公七年》則指出：「太伯……仲雍嗣之，斷髮文身，裸以為飾。」---剪頭髮和紋身，不穿衣服當成裝飾。先秦時代以來黥刑就是在犯人臉上刺字.在中國古代典籍中，就曾出現文身、鏤身、紮青、點青、雕青等文字，其他還有用刺青來作警示的例子如岳飛之母刺字的故事.但慢慢刺青已演變成個人裝飾的一種，例如在《四大奇書》之一《水滸傳》中，至少就有三個滿身刺青的重要角色：花和尚魯智深、九紋龍史進與浪子燕青。此外，還有族群文身的，東漢楊孚《異物志》就記載著廣西的文身族群：「雕題國，畫其面及身，刻其肌而青之，或若錦衣，或若魚鱗」。至今包括臺灣泰雅族和賽夏族之內，世界許多地方的原住民，都有在面部刺青的傳統，在許多文化中，刺青還是一種社會階級與地位的象徵。古埃及更利用刺青來畫分社會地位，英國維多利亞女王時代的婦女流行在唇部紋上紅色，類似現代的紋唇、紋眉等永久性彩妝的美容方式。";
    self.textview_1.layer.cornerRadius=8.0f;
    self.textview_1.layer.borderWidth=2.0;
    self.textview_1.layer.borderColor =[[UIColor colorWithRed:150.0/255.0
                                                        green:150.0/255.0
                                                         blue:150.0/255.0
                                                        alpha:1.0] CGColor];
  
    [self.textview_1 setUserInteractionEnabled:YES];
   [self.textview_1 setScrollEnabled:YES];

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

- (IBAction)sidebarButton:(id)sender {
}
@end
