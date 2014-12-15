//
//  GalleryCell.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 16/9/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *image_desc;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;
@end
