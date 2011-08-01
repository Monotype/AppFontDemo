//
//  AFLayersView.m
//  AppFontDemo
//
//  Created by andi on 27.07.11.
//  Copyright 2011 FontShop. All rights reserved.
//

#import "AFLayersView.h"
#import "QuartzCore/QuartzCore.h"

static NSInteger layerCount = 3;

@implementation AFLayersView


-(void)tick:(NSTimer*) timer {

  double currentTime = CACurrentMediaTime();
  double rotation = fmod(currentTime, 2 * M_PI) - M_PI;
  rotation *= 0.3;

  [CATransaction begin];
  [CATransaction setAnimationDuration:AFLAYERS_TICK_INTERVAL];
  [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
  for(CATextLayer* textLayer in self.layer.sublayers) {
    textLayer.position = self.layer.position;
    NSInteger random = arc4random() % [words count];
    CGFloat randomScale = arc4random()%100 / 100.0;
    CGFloat randomOpacity = randomScale;
    randomOpacity *= 0.2;
    randomScale += 0.5;
    if (randomScale > 1.2) {
      randomOpacity = 1.0;
    }
    textLayer.transform = CATransform3DIdentity;
    textLayer.transform = CATransform3DMakeScale(randomScale, randomScale, 1.0);
    textLayer.opacity = randomOpacity;
    textLayer.string = [NSString stringWithFormat:@"%@", [[words objectAtIndex:random] uppercaseString]];
    if (arc4random()%20 == 0) {
      textLayer.transform = CATransform3DRotate(textLayer.transform, M_PI, 0, 1, 0);
    }
  }
  [CATransaction commit];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
      words = [NSArray arrayWithObjects:@"&", @"every", @"a", @"fall", @"a", @"feel", @"a", @"fire", @"about", @"flower", @"above", @"for", @"after", @"freeze", @"all", @"from", @"almost", @"fruit", @"always", @"full", @"am", @"future", @"an", @"garden", @"an", @"gentle", @"and", @"get", @"another", @"giggle", @"are", @"give", @"as", @"good", @"as", @"gray", @"ask", @"green", @"at", @"ground", @"bad", @"grow", @"bake", @"happy", @"be", @"hard", @"beautiful", @"has", @"behind", @"have", @"believe", @"he", @"between", @"heart", @"bird", @"her", @"birthday", @"here", @"blossom", @"him", @"blue", @"his", @"breeze", @"holiday", @"but", @"hot", @"but", @"how", @"by", @"I", @"can", @"I", @"cold", @"if", @"come", @"imagine", @"could", @"in", @"d", @"ing", @"dark", @"ing", @"day", @"is", @"did", @"is", @"do", @"it", @"dream", @"keep", @"e", @"know", @"easy", @"leave", @"ed", @"let", @"little", @"squirrel", @"live", @"step", @"look", @"summer", @"love", @"sun", @"luck", @"sweet", @"ly", @"take", @"machine", @"taste", @"make", @"than", @"man", @"that", @"me", @"thaw", @"mind", @"the", @"month", @"the", @"moon", @"their", @"more", @"then", @"morning", @"there", @"must", @"they", @"my", @"this", @"nature", @"though", @"never", @"through", @"night", @"time", @"no", @"to", @"of", @"to", @"of", @"too", @"off", @"treat", @"on", @"trick", @"only", @"up", @"or", @"us", @"our", @"use", @"out", @"vacation", @"party", @"walk", @"past", @"want", @"play", @"warm", @"please", @"was", @"present", @"we", @"puddle", @"weather", @"r", @"were", @"rain", @"wet", @"relax", @"when", @"s", @"which", @"s", @"who", @"s", @"why", @"say", @"will", @"season", @"winter", @"see", @"with", @"she", @"woman", @"skin", @"work", @"sky", @"would", @"snow", @"y", @"er", @"life", @"es", @"light", @"essential", @"like", @"est", @"like", @"spring", @"so", @"year", @"some", @"you", @"spark", @"you", nil];
      [words retain];
      for (NSInteger i=0; i < layerCount; i++) {
        CATextLayer* textLayer;
        textLayer = [CATextLayer layer];
        textLayer.frame = CGRectMake(0, 0, 500, 120);
        textLayer.position = self.layer.position;
        // retina displays need this:
        textLayer.contentsScale = [[UIScreen mainScreen] scale];
        textLayer.font = CGFontCreateWithFontName((CFStringRef)@"SeroOT-Medium");
        textLayer.fontSize = 120;
        textLayer.contentsGravity = kCAGravityCenter;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.backgroundColor = [UIColor clearColor].CGColor;
        textLayer.foregroundColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
        [self.layer addSublayer:textLayer];
      }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
  [words release];
  [super dealloc];
}

@end
