//
//  AFButtonsViewController.m
//  AppFontDemo
//
//  Created by andi on 26.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "AFButtonsViewController.h"
#import "UIViewController+AppFonts.h"

@implementation AFButtonsViewController
@synthesize defaultButton;
@synthesize customButton;
@synthesize segmentedControl;

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
    [defaultButton release];
    [customButton release];
    [segmentedControl release];
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

  self.navigationItem.title = @"Buttons";
  [self setupNavigationItemFont];
  
  self.defaultButton.titleLabel.font = [UIFont fontWithName:@"SeroOT-Medium" size:18];
  self.customButton.titleLabel.font = [UIFont fontWithName:@"SeroOT-Medium" size:18];
  self.customButton.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
  [self.customButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
  
  // segmented control: loop through segments and render the text to an image. 
  // then set that image to the segmented
	UIFont*		font	= [UIFont fontWithName:@"SeroOT-Medium" size:14];
  for (NSInteger i=0; i<self.segmentedControl.numberOfSegments; i++) {
    NSString*	text = [self.segmentedControl titleForSegmentAtIndex:i];
    // get the size of the title string
    CGSize		size	= [text sizeWithFont:font];
    // Rendering context, call with options and set scale to 0.0 to work with retina displays
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();    
    // Set colors
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    // Set shadow
    CGContextSetShadow(context, CGSizeMake(0, -1.0), 1);
    // Render
    [text drawInRect:CGRectMake(0, 0, size.width, size.height) withFont:font];
    // Create image and release context
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.segmentedControl setImage:image forSegmentAtIndex:i];
  }
}

- (void)viewDidUnload
{
    [self setDefaultButton:nil];
    [self setCustomButton:nil];
    [self setSegmentedControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
