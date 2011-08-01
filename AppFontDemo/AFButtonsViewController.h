//
//  AFButtonsViewController.h
//  AppFontDemo
//
//  Created by andi on 26.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AFButtonsViewController : UIViewController {
  UIButton *defaultButton;
  UIButton *customButton;
  UISegmentedControl *segmentedControl;
}
@property (nonatomic, retain) IBOutlet UIButton *defaultButton;
@property (nonatomic, retain) IBOutlet UIButton *customButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;

@end
