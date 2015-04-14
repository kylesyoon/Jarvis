//
//  JARMotionGradientView.m
//  Jarvis
//
//  Created by Kyle Yoon on 4/13/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JARMotionGradientView.h"
#import "UIColor+Jarvis.h"

@implementation JARMotionGradientView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();

    CGFloat locations[4] = { 0.0, 0.6, 0.75, 1.0 };
    CFArrayRef colorArray = (__bridge CFArrayRef)@[
                                                   (id)[UIColor whiteColor].CGColor,
                                                   (id)[UIColor whiteColor].CGColor,
                                                   (id)[UIColor jarvis_lightBlue].CGColor,
                                                   (id)[UIColor whiteColor].CGColor
                                                   ];
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, locations);
    
    CGContextDrawRadialGradient(contextRef, gradientRef, self.center, 0, self.center, sqrt(pow(self.frame.size.width / 2, 2) + pow(self.frame.size.height / 2, 2)) + 50, 0);
    
    CGColorSpaceRelease(colorSpaceRef);
    CGGradientRelease(gradientRef);
    UIGraphicsEndImageContext();
}

@end
