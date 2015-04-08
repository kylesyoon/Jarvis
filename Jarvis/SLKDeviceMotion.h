//
//  SLKNextMotion.h
//  Jarvis
//
//  Created by Kyle Yoon on 4/7/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import <UIKit/UIKit.h>

@interface SLKDeviceMotion : CMDeviceMotion

- (BOOL)isNextMotion:(CMDeviceMotion *)motion;

@end
