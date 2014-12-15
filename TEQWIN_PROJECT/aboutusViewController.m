//
//  aboutusViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 27/10/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import "aboutusViewController.h"
#import "SWRevealViewController.h"
#import "Map_ViewController.h"
@interface aboutusViewController ()

@end

@implementation aboutusViewController

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
    
    
    
     UIImage *image = [UIImage imageNamed:@"teqapps_logo_ai_G.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect aRect = CGRectMake(0, 15, 320,76);
    [imageView setFrame:aRect];
    UIBezierPath *exclusionPath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMinY(imageView.frame), CGRectGetWidth( self.textview.frame), CGRectGetHeight(imageView.frame))];
     self.textview.textContainer.exclusionPaths = @[exclusionPath];
    [ self.textview addSubview:imageView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [ self.textview setFont:[UIFont fontWithName:@"Arial" size:12]];
    self.textview.text=@"\nFormed in 2010 TeqHost & TeqApps group of company has been serving many HK, China, Macau and international business ranging from Commercial sector, retail , Education and Government organization.\nWe provide IOS/Android application and web solution using the latest and industry most widely adopted technology. Our team of designers, developers  has expertise on a diverse range of platform and toolkit such as (Apple, Android API, SEO,  Joomla, Drupal, Silverstripe, Wordpress, PHP, MySql, Magento, VirtueMart, Zencart , HTML5, Java script, Flash Animation, etc.). And our marketing professional are well equipped with the latest toolkits to ensure your digital platform effectively create and maintain the relationship with your target customer.";

    self.textview.layer.cornerRadius=8.0f;
    self.textview.layer.borderWidth=2.0;
    //self.textview.layer.borderColor =[[UIColor colorWithRed:0.95 green:0.900 blue:0.0 alpha:1] CGColor];
    self.textview.layer.borderColor =[[UIColor grayColor]CGColor];
    CGRect frame =  self.textview.frame;
    frame.size.height =  self.textview.contentSize.height;
    self.textview.frame = frame;
    [ self.textview sizeToFit];
    [self.textview setScrollEnabled:NO];
     _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.title =@"關於我們";
    list =[[NSMutableArray alloc]init];
    [list addObject:[NSString stringWithFormat:@"TEQAPPS"]];
    [list addObject:[NSString stringWithFormat:@"Flat E, 9/F, Hing Yip Factory Bldg., 31 Hing Yip Street, Kwun Tong, Kowloon"]];
    [list addObject:[NSString stringWithFormat:@"http://www.teqapps.com/"]];
    [list addObject:[NSString stringWithFormat:@"(852)2389 3939"]];
        [list addObject:[NSString stringWithFormat:@"(852)2389 1499"]];
    [list addObject:[NSString stringWithFormat:@"info@teqapps.com"]];
    

       intro_list =[[NSMutableArray alloc]init];
    [intro_list addObject:[NSString stringWithFormat:@"TEQWIN SOLUTION LIMITED"]];
    NSLog(@"%@",list );

}
- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect
{
return 1;
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
        return [list count];
}
- (CGFloat) tableView: (UITableView*) tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    
    NSString *cellText = [list objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:cellText
     attributes:@
     {
     NSFontAttributeName: cellFont
     }];
    CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(_tableview.bounds.size.width, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];

            return rect.size.height + 35;

    
    
    
    
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
    if (tableView == self.tableview) {
        
        switch (indexPath.row) {
                
                
            case 0:
                
            {
                cell.detailTextLabel.textColor =[UIColor whiteColor];
                [cell.detailTextLabel setNumberOfLines:5];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Name：";
                
            }
                
                break;
                
            case 1:
                
            {
                cell.detailTextLabel.textColor =[UIColor whiteColor];
                [cell.detailTextLabel setNumberOfLines:10];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
                [cell.textLabel setNumberOfLines:2];
                cell.textLabel.text = @"Address：";
            }
                
                break;
            case 2:
                
            {
                [cell.detailTextLabel setNumberOfLines:5];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15 ];
                cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
                cell.detailTextLabel.textColor=[UIColor whiteColor];
                cell.textLabel.text = @"Website：";
                //cell.accessoryType=UITableViewCellAccessoryDetailButton;
            }
                
                break;

            case 3:
                
            {
                [cell.detailTextLabel setNumberOfLines:5];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15 ];
                cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
                cell.detailTextLabel.textColor=[UIColor whiteColor];
                cell.textLabel.text = @"Tel：";
                //cell.accessoryType=UITableViewCellAccessoryDetailButton;
            }
                
                break;
            case 4:
                
            {
                [cell.detailTextLabel setNumberOfLines:5];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15 ];
                cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
                cell.detailTextLabel.textColor=[UIColor whiteColor];
                cell.textLabel.text = @"Fax：";
                //cell.accessoryType=UITableViewCellAccessoryDetailButton;
            }
                
                break;
            case 5:
                
            {
                [cell.detailTextLabel setNumberOfLines:5];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
                cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:15];
                cell.detailTextLabel.textColor=[UIColor whiteColor];
                cell.textLabel.text = @"Email：";
                //cell.accessoryType=UITableViewCellAccessoryDetailButton;
            }
                
                break;
                
                
            
        }
        
        cell.textLabel.textColor=[UIColor colorWithRed:0.85 green:0.655 blue:0.0 alpha:1];
        cell.detailTextLabel.textColor=[UIColor colorWithRed:0.85 green:0.655 blue:0.0 alpha:1];
        cell.detailTextLabel.text =[list objectAtIndex:indexPath.row];
        
        cell.contentView.backgroundColor = [UIColor grayColor];
        
        
    }
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableview) {
        
        switch (indexPath.row) {
            case 1:{
                Map_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutus_map"];
                [self.navigationController pushViewController:mapVC animated:YES];
                break;
            }
            case 2:{
                
                NSURL *url = [NSURL URLWithString:@"http://www.teqwin.com.hk" ];
                [[UIApplication sharedApplication] openURL:url];
            }
                break;
            case 4:
                //Create the MailComposeViewController
                
            {
                MFMailComposeViewController *Composer = [[MFMailComposeViewController alloc]init];
               
                Composer.mailComposeDelegate = self;
                // email Subject
                [Composer setSubject:@"TEQWIN SOLUTION LIMITED"];
                //email body
                // [Composer setMessageBody:self.selectedTattoo_Master.name isHTML:NO];
                //recipient
                [Composer setToRecipients:[NSArray arrayWithObjects:@"sing.l@teqapps.com", nil]];            //get the filePath resource
                
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
    {NSURL *url =[NSURL URLWithString:@"23893939"];
        [[UIApplication sharedApplication] openURL:url];
       
        
    }}
- (IBAction)segmented:(id)sender {
    switch (_segmentControl.selectedSegmentIndex) {
        case 0:
            list =[[NSMutableArray alloc]init];
            [list addObject:[NSString stringWithFormat:@"TEQHOST Asia is a dedicated Solution Architect and Systems Integration business. We address business-critical problems in order to implement major change programs in large and complex systems across a variety of industries throughout the APAC, and are driven to be recognized for excellence in performance, value-creation and service, concentrating on delivering outcomes for our clients, rather than simply seeing a series of deliveries."]];
                      [_tableview reloadData];
            break;
        case 1:
            list =[[NSMutableArray alloc]init];
            [list addObject:[NSString stringWithFormat:@"TEQWIN SOLUTION LIMITED"]];
            [list addObject:[NSString stringWithFormat:@"觀塘興業街 31 號,興業工廠大廈 9樓E室"]];
            [list addObject:[NSString stringWithFormat:@"http://www.teqwin.com.hk/"]];
            [list addObject:[NSString stringWithFormat:@"(852)23893939"]];
            [list addObject:[NSString stringWithFormat:@"teqwin@gmail.com"]];
                  [_tableview reloadData];
        default:
            break;
    }}
@end
