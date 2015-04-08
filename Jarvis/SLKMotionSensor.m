//
//  JVSMotionSensor.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "SLKMotionSensor.h"
#import <CoreMotion/CoreMotion.h>
#import "SLKMultipeerClient.h"
#import "SLKConstants.h"
#import "SLKDeviceMotion.h"

static CGFloat const SLKMotionUpdateInterval = 0.05;

@interface SLKMotionSensor()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) SLKDeviceMotion *nextMotion;

@property (nonatomic) NSUInteger currentNextMotionIndex;
@property (nonatomic) NSUInteger currentBackMotionIndex;

@end

@implementation SLKMotionSensor

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
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    if (!self.motionManager) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    // Enabling muting by covering sensor.
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
    
    self.nextMotion = [[SLKDeviceMotion alloc] init];
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
    if (self.motionManager.deviceMotionAvailable && !self.motionManager.deviceMotionActive) {
        self.motionManager.deviceMotionUpdateInterval = SLKMotionUpdateInterval;
        NSLog(@"Starting device motion updates");
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                    [self analyzeDeviceMotion:motion];
                                                }];
    } else {
        NSLog(@"ERROR: Device Motion not available!");
    }
}

- (void)analyzeDeviceMotion:(CMDeviceMotion *)motion
{    
    if ([self.nextMotion isNextMotion:motion]) {
        [self.delegate detectedMotion:MessagePayload.next];
    }
}


@end
