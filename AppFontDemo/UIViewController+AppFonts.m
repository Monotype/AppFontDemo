//
//  UIViewController+AppFonts.m
//  AppFontDemo
//
//  Created by andi on 26.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "UIViewController+AppFonts.h"


@implementation UIViewController (UIViewController_AppFonts)

-(void)backTo {
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupNavigationItemFont {
  UILabel* label = [[UILabel alloc] initWithFrame:self.navigationController.navigationBar.frame];
  label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  label.font = [UIFont fontWithName:@"SeroOT-Medium" size:24];
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor whiteColor];
  label.text = self.navigationItem.title;
  label.textAlignment = UITextAlignmentCenter;
  label.shadowColor = [UIColor colorWithWhite:0.2 alpha:1];
  label.shadowOffset = CGSizeMake(0.0, -1.0);
  self.navigationItem.titleView = label;
  [label release];
  
  // create a custom back button if we're not the root controller
  if ([self.navigationController.viewControllers count] > 1) {
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    
    UIImage* buttonBackground = [UIImage imageNamed:@"back-button.png"];
    buttonBackground = [buttonBackground stretchableImageWithLeftCapWidth:13 topCapHeight:buttonBackground.size.height];
    [button setBackgroundImage:buttonBackground forState:UIControlStateNormal];  
    
    buttonBackground = [UIImage imageNamed:@"back-button-hi.png"];
    buttonBackground = [buttonBackground stretchableImageWithLeftCapWidth:13 topCapHeight:buttonBackground.size.height];
    [button setBackgroundImage:buttonBackground forState:UIControlStateHighlighted];  
    
    [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside]; 
    
    // measure the title string and set the button size from that
    NSString* title = @"Back";
    
    UIFont* font = [UIFont fontWithName:@"SeroOT-Medium" size:14];
    CGSize size = [title sizeWithFont:font];
    
    button.frame = CGRectMake(0, 0, size.width + buttonBackground.size.width, 30);
    button.autoresizingMask = UIViewAutoresizingNone;
    
    [button setTitle:title forState:UIControlStateNormal]; //self.navigationItem.leftBarButtonItem.title;
    button.titleLabel.font = font;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.titleLabel.shadowColor = [UIColor colorWithWhite:0.2 alpha:1];
    button.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView: button] autorelease];  
  }
  
}


@end
