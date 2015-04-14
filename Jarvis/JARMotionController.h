//
//  JVSMotionSensor.h
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MotionControllerDelegate

@required
/// Delegate method for the proximity sensor. Will fire on state change.
- (void)changedToProximityState:(BOOL)state;
@optional
/// Delegate method for motion detection. Will fire on detecting specified motions.
- (void)detectedMotion:(NSString *)motion;

@end

@interface JARMotionController : NSObject

@property id<MotionControllerDelegate> delegate;
/// Singleton.
+ (instancetype)sharedInstance;
/// Starts pushing device motion updates.
- (void)startGettingDeviceMotion;
- (void)stopGettingDeviceMotion;

@end
