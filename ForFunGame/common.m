//
//  common.m
//  smallGame
//
//  Created by MoAir on 11/5/2013.
//  Copyright (c) 2013 MoAir. All rights reserved.
//

#import "common.h"


// since we are using CORE fundation then __bridge cast required
void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//to get a color space with which you’ll draw the gradient.
    CGFloat locations[] = { 0.0, 1.0,0.7 }; //you set up an array that tracks the location of each color within the range of the gradient. A value of 0 would mean the start of the gradient, 1 would mean the end of the gradient.
    UIColor* third = [UIColor colorWithRed:0.5 green:0.5 blue:0.0 alpha:0.5];
   
    NSArray *colors = @[(__bridge id) startColor, (__bridge  id) endColor, (__bridge id)third.CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);//  Bridging casts are required for moving Core Foundation objects to Cocoa objects.
   
    //calculate the start and end point for where you want to draw the gradient
   // CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint startPoint = CGPointMake(0, 0);

    CGContextSaveGState(context);
   // CGContextAddArc(context, 100, 200, 50, 2, 90, 1);
 //   CGContextStrokePath(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    // More coming...
}