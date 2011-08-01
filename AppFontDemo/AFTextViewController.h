//
//  AFTextViewController.h
//  AppFontDemo
//
//  Created by andi on 27.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AFTextViewController : UIViewController {
    
  UILabel *label;
  UITextField *textField;
  UITextView *textView;
}
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
