//
//  RootViewController.m
//  AppFontDemo
//
//  Created by andi on 26.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "RootViewController.h"
#import "AFButtonsViewController.h"
#import "AFTextViewController.h"
#import "AFLayersViewController.h"
#import "AFWebViewController.h"
#import "AFFontListViewController.h"
#import "UIViewController+AppFonts.h"

typedef enum {
  ROOT_CELL_LABEL_TAG = 3001,
} RootCellViewTags;

@implementation RootViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupNavigationItemFont];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectInset(cell.bounds, 5, 5)];
    
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.font = [UIFont fontWithName:@"BasicGothicMobiPro-BlackItalic" size:18];
    label.textColor = [UIColor blackColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.tag = ROOT_CELL_LABEL_TAG;
    [cell addSubview:label];
    [label release];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  UILabel* titleLabel = (UILabel*)[cell viewWithTag:ROOT_CELL_LABEL_TAG];
  switch (indexPath.row) {
    case 0:
      titleLabel.text = [NSString stringWithFormat:@"Buttons", indexPath.row];
      break;
    case 1:
      titleLabel.text = [NSString stringWithFormat:@"Text views", indexPath.row];
      break;
    case 2:
      titleLabel.text = [NSString stringWithFormat:@"Layers", indexPath.row];
      break;
    case 3:
      titleLabel.text = [NSString stringWithFormat:@"WebView", indexPath.row];
      break;
    case 4:
      titleLabel.text = [NSString stringWithFormat:@"List of available fonts", indexPath.row];
      break;
    default:
      break;
  }
  
  // Configure the cell.
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIViewController* vc = nil;
  switch (indexPath.row) {
    case 0:
      vc = [[AFButtonsViewController alloc] initWithNibName:@"AFButtonsViewController" bundle:nil];
      break;
    case 1:
      vc = [[AFTextViewController alloc] initWithNibName:@"AFTextViewController" bundle:nil];
      break;
    case 2:
      vc = [[AFLayersViewController alloc] initWithNibName:@"AFLayersViewController" bundle:nil];
      break;
    case 3:
      vc = [[AFWebViewController alloc] initWithNibName:@"AFWebViewController" bundle:nil];
      break;
    case 4:
      vc = [[AFFontListViewController alloc] initWithNibName:@"AFFontListViewController" bundle:nil];
      break;
    default:
      break;
  }
  if (vc != nil) {
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
  }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
