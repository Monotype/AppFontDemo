//
//  AFTextViewController.m
//  AppFontDemo
//
//  Created by andi on 27.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "AFTextViewController.h"
#import "UIViewController+AppFonts.h"

@implementation AFTextViewController
@synthesize label;
@synthesize textField;
@synthesize textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
  }
  return self;
}

- (void)dealloc
{
  [label release];
  [textField release];
  [textView release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.title = @"Text Views";
  [self setupNavigationItemFont];
  self.label.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:18];
  self.textField.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:14];
  self.textView.layer.borderColor = [UIColor grayColor].CGColor;
  self.textView.layer.borderWidth = 1.0;
  self.textView.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:14];
}

- (void)viewDidUnload
{
  [self setLabel:nil];
  [self setTextField:nil];
  [self setTextView:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

@end
