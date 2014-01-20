//
//  CustomView.m
//  smallGame
//
//  Created by MoAir on 11/5/2013.
//  Copyright (c) 2013 MoAir. All rights reserved.
//

#import "CustomView.h"
#import "common.h"
@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
        /*
     One of the interesting things about contexts is that they are stateful. That means that when you call methods to change something like the fill color for example, the fill color will remain set to that color until you change it to something different later.
     */
    CGContextRef context = UIGraphicsGetCurrentContext();//to get the Core Graphics Context that you’ll use in the rest of the method.
    
    UIColor * redColor = [UIColor colorWithRed:0.0 green:1.7 blue:1.1 alpha:1.0]; // get the red color
    
   // CGContextSetFillColorWithColor(context, redColor.CGColor );//to set the fill color to red
  //  CGContextFillRect(context, self.bounds);
    
//    UIColor * whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];// get the color
   UIColor * lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];//get the color
//    
   CGRect paperRect = self.bounds;
//    
   drawLinearGradient(context, paperRect, redColor.CGColor, lightGrayColor.CGColor);
}


@end
