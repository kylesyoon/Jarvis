//
//  JVSMotionSensor.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JARMotionController.h"
#import <CoreMotion/CoreMotion.h>
#import "JARConstants.h"

static const CGFloat JARMotionUpdateInterval = 0.1;
static const CGFloat JARRollTriggerThreshold = 75.0;
static const CGFloat JARRollTriggerError = 30;
static const CGFloat JARMotionTriggerDelay = 0.5;

@interface JARMotionController()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) CMAttitude *previousAttitude;
@property (nonatomic) BOOL didNext;
@property (nonatomic) BOOL didBack;

@end

@implementation JARMotionController

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
    
    if (self) {
        if (!self.motionManager) {
            self.motionManager = [[CMMotionManager alloc] init];
        }
        // Enabling muting by covering sensor.
        [UIDevice currentDevice].proximityMonitoringEnabled = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChanged:) name:@"UIDeviceProximityStateDidChangeNotification"
                                                   object:nil];
    }
    
    return self;
}

#pragma mark - NSNotification

- (void)sensorStateChanged:(NSNotification *)notification
{
    [self.delegate changedToProximityState:[[UIDevice currentDevice] proximityState]];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Device Motion

- (void)startGettingDeviceMotion
{
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    
    if (self.motionManager.deviceMotionAvailable && !self.motionManager.deviceMotionActive) {
        self.motionManager.deviceMotionUpdateInterval = JARMotionUpdateInterval;
        NSLog(@"Starting device motion updates");
        [self.motionManager startDeviceMotionUpdatesToQueue:motionQueue
                                                withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                        [self analyzeDeviceMotion:motion];
                                                    }];
                                                }];
    } else {
        // TODO: Error handling.
        NSLog(@"ERROR: Device Motion not available!");
    }
}

- (void)stopGettingDeviceMotion
{
    [self.motionManager stopDeviceMotionUpdates];
}

- (void)analyzeDeviceMotion:(CMDeviceMotion *)motion
{
    if (self.previousAttitude) {
        [self.previousAttitude multiplyByInverseOfAttitude:motion.attitude];
        
        CGFloat roll = [self getDegrees:self.previousAttitude.roll];
        CGFloat pitch = [self getDegrees:self.previousAttitude.pitch];
        CGFloat yaw = [self getDegrees:self.previousAttitude.yaw];
        
        if (fabs(pitch) < JARRollTriggerError && fabs(yaw) < JARRollTriggerError) {
            if (roll > JARRollTriggerThreshold && !self.didNext) {
                self.didBack = YES;
                self.didNext = NO;
                [self.delegate detectedMotion:MessagePayload.back];
                [self restartDeviceMotionUpdatesAfterDelay:JARMotionTriggerDelay];
            } else if (roll < -JARRollTriggerThreshold && !self.didBack) {
                self.didBack = NO;
                self.didNext = YES;
                [self.delegate detectedMotion:MessagePayload.next];
                [self restartDeviceMotionUpdatesAfterDelay:JARMotionTriggerDelay];
            } else {
                self.didBack = NO;
                self.didNext = NO;
            }
        } else {
            self.didBack = NO;
            self.didNext = NO;
        }
    }
    self.previousAttitude = motion.attitude;
}

- (CGFloat)getDegrees:(CGFloat)radians
{
    return radians * 180.0 / M_PI;
}

- (void)restartDeviceMotionUpdatesAfterDelay:(CGFloat)delay
{
    [self.motionManager stopDeviceMotionUpdates];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self startGettingDeviceMotion];
    });
}

@end
