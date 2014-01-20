//
//  CircleView.m
//  smallGame
//
//  Created by MoAir on 11/7/2013.
//  Copyright (c) 2013 MoAir. All rights reserved.
//

#import "CircleView.h"


@implementation CircleView
@synthesize positionX = _positionX;
@synthesize positionY = _positionY;
// variable that is used only in this class



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        

          }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    self.positionX = 384;
    self.positionY = 100;//self.superview.frame.origin.y ;
        CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    UIColor* rColor = [UIColor colorWithRed:0.0 green:0.3 blue:0.1 alpha:1.0];
    UIColor* blueColor = [UIColor colorWithRed:0.2 green:0.5 blue:1.0 alpha:1.0];
    
 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//to get a color space with which you’ll draw the gradient.
    
 //you set up an array that tracks the location of each color within the range of the gradient. A value of 0 would mean the start of the gradient, 1 would mean the end of the gradient.
  CGFloat locations[] = { 0.0, 1.0,0.0 };   
    
 UIColor* third = [UIColor colorWithRed:0.5 green:0.5 blue:0.0 alpha:0.5];
 
 NSArray *colors = @[(__bridge id) blueColor.CGColor, (__bridge  id) rColor.CGColor, (__bridge id)third.CGColor];
 
 CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);//  Bridging casts are required for moving Core Foundation objects to Cocoa objects.
 
 //calculate the start and end point for where you want to draw the gradient
 // CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
 CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
 CGPoint startPoint = CGPointMake(0, 0);
 
 CGContextSaveGState(context);
    
    
  CGContextAddArc(context, self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.height/2, 7, 0, 1);
  //  CGContextStrokePath(context);
 //CGContextAddRect(context, rect);
 CGContextClip(context);
 CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
 CGContextRestoreGState(context);
 
 CGGradientRelease(gradient);
 CGColorSpaceRelease(colorSpace);
}
int reduce;
@end
