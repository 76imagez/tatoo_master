//
//  ShareViewController.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 15/8/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFShareCircleView.h"
@interface ShareViewController : UIViewController<CFShareCircleViewDelegate>{
    CFShareCircleView *shareCircleView;
}

@end
