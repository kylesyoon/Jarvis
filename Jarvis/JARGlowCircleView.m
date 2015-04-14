//
//  JARGlowCircleView.m
//  Jarvis
//
//  Created by Kyle Yoon on 4/13/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JARGlowCircleView.h"
#import "UIColor+Jarvis.h"

@implementation JARGlowCircleView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *circle = [UIBezierPath bezierPath];
    [circle addArcWithCenter:self.center radius:self.frame.size.width / 2 startAngle:M_PI endAngle:M_PI clockwise:YES];
    circle.lineWidth = 10.0;
    [[UIColor jarvis_lightBlue] setStroke];
    [circle stroke];
    
    self.backgroundColor = [UIColor clearColor];
}


@end
