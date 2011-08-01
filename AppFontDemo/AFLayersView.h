//
//  AFLayersView.h
//  AppFontDemo
//
//  Created by andi on 27.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AFLAYERS_TICK_INTERVAL 1.8

@interface AFLayersView : UIView {
  NSArray* words;
}

-(void)tick:(NSTimer*) timer;

@end
