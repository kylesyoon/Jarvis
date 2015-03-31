//
//  JVSMotionSensor.h
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

typedef void (^MotionUpdateCompletion)(CMDeviceMotion *motion, NSError *error);

@protocol JVSMotionSensorDelegate

- (void)sendMessage:(NSString *)message;

@end

@interface JVSMotionSensor : NSObject

@property id<JVSMotionSensorDelegate> delegate;

+ (instancetype)sharedInstance;
- (void)startGettingDeviceMotion;




@end
