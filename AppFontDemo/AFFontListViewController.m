//
//  AFFontListViewController.m
//  AppFontDemo
//
//  Created by andi on 28.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "AFFontListViewController.h"
#import "UIViewController+AppFonts.h"

typedef enum {
  FONTLIST_CELL_LABEL_TAG = 3001,
} FontListCellViewTags;


@implementation AFFontListViewController

@synthesize data;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
  self.data = nil;
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
  self.navigationItem.title = @"Font listing";
  [self setupNavigationItemFont];
  
  self.tableView.rowHeight = 80;
  
  self.data = [NSMutableArray arrayWithCapacity:40];
  // Get all the fonts on the system
  NSArray *familyNames = [UIFont familyNames];
  for( NSString *familyName in familyNames ){
    NSMutableArray* familyContents = [NSMutableArray array];
    
    NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    for( NSString *fontName in fontNames ){
      [familyContents addObject:fontName];
    }
    [self.data addObject:[NSDictionary dictionaryWithObjectsAndKeys:familyContents, @"fonts", familyName, @"name", nil]];
  }
  // sort families by name:
  [self.data sortUsingComparator:(NSComparator)^(id obj1, id obj2) {
    return [[obj1 valueForKey:@"name"] caseInsensitiveCompare:[obj2 valueForKey:@"name"]];
  }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [self.data count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSDictionary* familyDict = [self.data objectAtIndex:section];
  return [familyDict objectForKey:@"name"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSDictionary* familyDict = [self.data objectAtIndex:section];
  return [[familyDict objectForKey:@"fonts"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectInset(cell.bounds, 5, 5)];
    label.frame = CGRectInset(label.frame, 15, 0);
    
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.textColor = [UIColor blackColor];
    label.highlightedTextColor = [UIColor whiteColor];
    label.tag = FONTLIST_CELL_LABEL_TAG;
    [cell addSubview:label];
    [label release];
    
  }
  
  UILabel* titleLabel = (UILabel*)[cell viewWithTag:FONTLIST_CELL_LABEL_TAG];
  NSDictionary* familyDict = [self.data objectAtIndex:indexPath.section];
  NSString* fontName =  [[familyDict objectForKey:@"fonts"] objectAtIndex:indexPath.row];

  titleLabel.text = fontName;
  titleLabel.font = [UIFont fontWithName:fontName size:24];

  return cell;
}


@end
