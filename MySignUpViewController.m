//
//  MySignUpViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MySignUpViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MySignUpViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MySignUpViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tattoo_login_2.png"]]];
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tattoo_menu_logo.png"]]];
    
    // Change button apperance
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"dismiss_on.png"] forState:UIControlStateNormal];
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"dismiss_off.png"] forState:UIControlStateHighlighted];
    
    
    [self.signUpView.usernameField setPlaceholder:@"Enter Username"];
    [self.signUpView.passwordField setPlaceholder:@"Enter Password"];
    [self.signUpView.emailField setPlaceholder:@"Enter Email"];
    
    // Add background for fields
    // [self setFieldsBackground:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SignUpFieldBG.png"]]];
    [self.signUpView insertSubview:fieldsBackground atIndex:1];
    [self.signUpView.passwordField setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.signUpView.usernameField setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.signUpView.emailField setValue:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    // Remove text shadow
    CALayer *layer = self.signUpView.usernameField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.signUpView.passwordField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.signUpView.emailField.layer;
    layer.shadowOpacity = 0.0f;
    [self.signUpView.usernameField setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [self.signUpView.passwordField setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [self.signUpView.emailField setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    
    
    [self.signUpView.passwordField setValue:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [self.signUpView.usernameField setValue:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.signUpView.emailField setValue:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.signUpView.usernameField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0]];
    [self.signUpView.passwordField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0]];
    [self.signUpView.emailField setTextColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0]];


}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
    [self.signUpView.dismissButton setFrame:CGRectMake(260.0f, 30.0f, 40.0f, 40.0f)];
    [self.signUpView.logo setFrame:CGRectMake(75.0f, 70.0f,178.0f, 41.5f)];

    [self.signUpView.signUpButton setFrame:CGRectMake(0.0f,300.0f, 320.0f, 40.0f)];
    //  [self.fieldsBackground setFrame:CGRectMake(35.0f, 145.0f, 250.0f, 174.0f)];
    [self.signUpView.usernameField setFrame:CGRectMake(0.0f, 145.0f,320.0f, 50.0f)];
    [self.signUpView.passwordField setFrame:CGRectMake(0.0f, 195.0f,320.0f, 50.0f)];
    [self.signUpView.emailField setFrame:CGRectMake(0.0f, 245.0f, 320.0f, 50.0f)];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
