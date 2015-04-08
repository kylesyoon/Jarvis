//
//  JVSMotionSensor.h
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLKConstants.h"

@protocol MotionSensorDelegate

@required
- (void)changedToProximityState:(BOOL)state;

@optional
- (void)detectedMotion:(NSString *)motion;

@end

@interface SLKMotionSensor : NSObject

@property id<MotionSensorDelegate> delegate;
/// Singleton.
+ (instancetype)sharedInstance;
/// Starts pushing device motion updates.
- (void)startGettingDeviceMotion;

@end
