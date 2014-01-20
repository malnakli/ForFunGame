//
//  boxView.m
//  smallGame
//
//  Created by MoAir on 11/7/2013.
//  Copyright (c) 2013 MoAir. All rights reserved.
//

#import "boxView.h"
#import "common.h"
@implementation boxView

@synthesize positionX =_positionX;

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
    
    self.positionY_RelatToItsSuperView = self.frame.origin.y ;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* redColor = [UIColor colorWithRed:1.0 green:0.3 blue:0.1 alpha:1.0];
    UIColor* yellowColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.1 alpha:1.0];
    
    
    drawLinearGradient(context, self.bounds, redColor.CGColor, yellowColor.CGColor);

}




@end
