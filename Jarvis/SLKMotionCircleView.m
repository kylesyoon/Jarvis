//
//  MotionCircleView.m
//  Jarvis
//
//  Created by Kyle Yoon on 4/1/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "SLKMotionCircleView.h"

@implementation SLKMotionCircleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1.0];
        self.layer.cornerRadius = self.frame.size.width / 2;
    }
    
    return self;
}

@end
