//
//  JVSMotionSensor.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JVSMotionSensor.h"
#import "JVSMultipeerClient.h"

@interface JVSMotionSensor()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property BOOL isZMovement;

@end

@implementation JVSMotionSensor

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (!self.motionManager) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
    
    return self;
}

- (void)startGettingDeviceMotion
{
    if (self.motionManager.deviceMotionAvailable) {
        self.motionManager.deviceMotionUpdateInterval = 0.05;
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                withHandler:[self completionForDeviceMotionUpdates]];
    }
}

- (CMDeviceMotionHandler)completionForDeviceMotionUpdates
{
    typeof(self) __weak weakSelf = self;
    return ^(CMDeviceMotion *motion, NSError *error) {
//        NSLog(@"%.3f", motion.userAcceleration.z);
        if (motion.rotationRate.z >= 8.0 && motion.userAcceleration.z < 5.0 && motion.userAcceleration.z > -5.0) {
            // Snap forward.
            NSLog(@"NEXT TRIGGER ROT.Z %.3f", motion.rotationRate.z);
            
            [weakSelf.delegate sendMessage:JVSNextMessage];
            [weakSelf restartDeviceMotionUpdatesAfterDelay];
        } else if (motion.rotationRate.z <= -8.0 && motion.userAcceleration.z < 5.0 && motion.userAcceleration.z > -5.0) {
            // Snap backward.
            NSLog(@"BACK TRIGGER ROT.Z %.3f", motion.rotationRate.z);
            
            [weakSelf.delegate sendMessage:JVSBackMessage];
            [weakSelf restartDeviceMotionUpdatesAfterDelay];
        } else if ((motion.userAcceleration.z > 3 && motion.userAcceleration.z < 5.0) || (motion.userAcceleration.z < -3 && motion.userAcceleration.z > -5)) {
            // Slap the phone.
            self.isZMovement = YES;
            NSLog(@"Z MOVEMENT %.3f", motion.userAcceleration.z);
        } else if (self.isZMovement && fabs(motion.userAcceleration.z) && fabs(motion.userAcceleration.z) && fabs(motion.userAcceleration.z)) {
            NSLog(@"Stopped after Z Movement");
            [weakSelf.delegate sendMessage:JVSESCMessage];
            [weakSelf restartDeviceMotionUpdatesAfterDelay];
            self.isZMovement = NO;
        }
    };
}

- (void)restartDeviceMotionUpdatesAfterDelay
{
    [self.motionManager stopDeviceMotionUpdates];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startGettingDeviceMotion];
    });
}

- (void)sensorStateChanged:(NSNotification *)notification
{
    NSLog(@"NOTIFICATION: %@", notification);
    if ([[UIDevice currentDevice] proximityState] == YES) {
        [self.delegate sendMessage:JVSMuteMessage];\
    } else {
        [self.delegate sendMessage:JVSUnmuteMessage];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
