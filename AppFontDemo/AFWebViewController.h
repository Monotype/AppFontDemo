//
//  AFWebView.h
//  AppFontDemo
//
//  Created by andi on 28.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AFWebViewController : UIViewController {
    
  UIWebView *webView;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
