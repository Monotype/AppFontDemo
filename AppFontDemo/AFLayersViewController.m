//
//  AFLayersViewController.m
//  AppFontDemo
//
//  Created by andi on 27.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "AFLayersViewController.h"
#import "UIViewController+AppFonts.h"
#import "AFLayersView.h"

@implementation AFLayersViewController

@synthesize animationTimer;

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
  [animationTimer invalidate];
  self.animationTimer = nil;
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
  self.navigationItem.title = @"Layers";
  [self setupNavigationItemFont];
  self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:AFLAYERS_TICK_INTERVAL target:self.view selector:@selector(tick:) userInfo:nil repeats:YES];
  // fire off first tick now
  [(AFLayersView*)self.view tick:nil];
}

- (void)viewDidUnload
{
  [animationTimer invalidate];
  self.animationTimer = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

@end
