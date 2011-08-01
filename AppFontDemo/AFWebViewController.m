//
//  AFWebView.m
//  AppFontDemo
//
//  Created by andi on 28.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "AFWebViewController.h"
#import "UIViewController+AppFonts.h"


@implementation AFWebViewController
@synthesize webView;

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
  [webView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) loadPage {
  NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
  [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.title = @"WebView";
  [self setupNavigationItemFont];
  [self loadPage];
}

- (void)viewDidUnload
{
  [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

@end
