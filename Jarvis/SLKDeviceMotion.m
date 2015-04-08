
//
//  SLKNextMotion.m
//  Jarvis
//
//  Created by Kyle Yoon on 4/7/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//


//static CGFloat const AccelXFirstLowerBound = -2.0;
//static CGFloat const AccelXFirstUpperBound = 0;
//static CGFloat const AccelXSecondLowerBound = -3.0;
//static CGFloat const AccelXSecondUpperBound = 0;
//static CGFloat const AccelXThirdLowerBound = -2.0;
//static CGFloat const AccelXThirdUpperBound = 0;
//static CGFloat const AccelXFourthLowerBound = 0;
//static CGFloat const AccelXFourthUpperBound = 5.0;
//static CGFloat const AccelXFifthLowerBound = 5.0;
//static CGFloat const AccelXFifthUpperBound = 10.0;
//static CGFloat const AccelXSixthLowerBound = 10.0;
//static CGFloat const AccelXSixthUpperBound = 15.0;
//static CGFloat const AccelXSeventhLowerBound = 7.5;
//static CGFloat const AccelXSeventhUpperBound = 12.5;
//static CGFloat const AccelXEighthLowerBound = 0;
//static CGFloat const AccelXEighthUpperBound = 5.0;
//static CGFloat const AccelXNinthLowerBound = 0;
//static CGFloat const AccelXNinthUpperBound = 3.0;
//static CGFloat const AccelXTenthLowerBound = -3.0;
//static CGFloat const AccelXTenthUpperBound = 3.0;
//
//static CGFloat const AccelYFirstLowerBound = -3.0;
//static CGFloat const AccelYFirstUpperBound = 0;
//static CGFloat const AccelYSecondLowerBound = -3.0;
//static CGFloat const AccelYSecondUpperBound = 0;
//static CGFloat const AccelYThirdLowerBound = -3.0;
//static CGFloat const AccelYThirdUpperBound = 0;
//static CGFloat const AccelYFourthLowerBound = -5;
//static CGFloat const AccelYFourthUpperBound = -2;
//static CGFloat const AccelYFifthLowerBound = -5;
//static CGFloat const AccelYFifthUpperBound = -2;
//static CGFloat const AccelYSixthLowerBound = -2.0;
//static CGFloat const AccelYSixthUpperBound = 2.0;
//static CGFloat const AccelYSeventhLowerBound = 0;
//static CGFloat const AccelYSeventhUpperBound = 3.0;
//static CGFloat const AccelYEighthLowerBound = -2.0;
//static CGFloat const AccelYEighthUpperBound = 2.0;
//static CGFloat const AccelYNinthLowerBound = -2.0;
//static CGFloat const AccelYNinthUpperBound = 2.0;
//static CGFloat const AccelYTenthLowerBound = -2.0;
//static CGFloat const AccelYTenthUpperBound = 2.0;
//
//static CGFloat const AccelZFirstLowerBound = -1.0;
//static CGFloat const AccelZFirstUpperBound = 1.0;
//static CGFloat const AccelZSecondLowerBound = -1.0;
//static CGFloat const AccelZSecondUpperBound = 1.0;
//static CGFloat const AccelZThirdLowerBound = -1.0;
//static CGFloat const AccelZThirdUpperBound = 1.0;
//static CGFloat const AccelZFourthLowerBound = -1.0;
//static CGFloat const AccelZFourthUpperBound = 1.0;
//static CGFloat const AccelZFifthLowerBound = -1.0;
//static CGFloat const AccelZFifthUpperBound = 1.0;
//static CGFloat const AccelZSixthLowerBound = 0;
//static CGFloat const AccelZSixthUpperBound = 5.0;
//static CGFloat const AccelZSeventhLowerBound = 0;
//static CGFloat const AccelZSeventhUpperBound = 3.0;
//static CGFloat const AccelZEighthLowerBound = 0;
//static CGFloat const AccelZEighthUpperBound = 3.0;
//static CGFloat const AccelZNinthLowerBound = 0;
//static CGFloat const AccelZNinthUpperBound = 3.0;
//static CGFloat const AccelZTenthLowerBound = -3.0;
//static CGFloat const AccelZTenthUpperBound = 0;

//static CGFloat const RotXSixthLowerBound = -5.0;
//static CGFloat const RotXSixthUpperBound = 5.0;
//static CGFloat const RotYSixthLowerBound = -5.0;
//static CGFloat const RotYSixthUpperBound = 5.0;
//static CGFloat const RotZSixthLowerBound = 0;
//static CGFloat const RotZSixthUpperBound = 15.0;
//
//static CGFloat const RotXSeventhLowerBound = -3.0;
//static CGFloat const RotXSeventhUpperBound = 3.0;
//static CGFloat const RotYSeventhLowerBound = -5.0;
//static CGFloat const RotYSeventhUpperBound = 5.0;
//static CGFloat const RotZSeventhLowerBound = -7.5;
//static CGFloat const RotZSeventhUpperBound = 10.0;
//
//static CGFloat const RotXEighthLowerBound = -3.0;
//static CGFloat const RotXEighthUpperBound = 3.0;
//static CGFloat const RotYEighthLowerBound = -3.0;
//static CGFloat const RotYEighthUpperBound = 3.0;
//static CGFloat const RotZEighthLowerBound = -10.0;
//static CGFloat const RotZEighthUpperBound = 0;
//
//static CGFloat const RotXNinthLowerBound = -3.0;
//static CGFloat const RotXNinthUpperBound = 3.0;
//static CGFloat const RotYNinthLowerBound = -3.0;
//static CGFloat const RotYNinthUpperBound = 3.0;
//static CGFloat const RotZNinthLowerBound = -10.0;
//static CGFloat const RotZNinthUpperBound = 0;
//
//static CGFloat const RotXTenthLowerBound = -3.0;
//static CGFloat const RotXTenthUpperBound = 3.0;
//static CGFloat const RotYTenthLowerBound = -3.0;
//static CGFloat const RotYTenthUpperBound = 3.0;
//static CGFloat const RotZTenthLowerBound = -10.0;
//static CGFloat const RotZTenthUpperBound = 0;

#import "SLKDeviceMotion.h"

typedef NS_ENUM(NSInteger, SLKNextMotionSignaturePoints) {
    SLKNextMotionNotSignaturePoint, // No signature point has been identified.
    SLKNextMotionStartPoint, // When rotZ > 10
    SLKNextMotionHighPoint, // If rotZ has not yet peaked, then this point.
    SLKNextMotionDecreasingRotZPoint, // rotZ starts to decrease from peak.
    SLKNextMotionNegativeRotZPoint, // rotZ hits negative.
    SLKNextMotionNegativePeakPoint // rotZ is super negative.
};

typedef NS_ENUM(NSInteger, SLKBackMotionSignaturePoints) {
    SLKBackMotionNotSignaturePoint, // No signature point has been identified.
    SLKBackMotionStartPoint, // When rotZ > 10
};

static CGFloat const RotXFirstLowerBound = -5.0;
static CGFloat const RotXFirstUpperBound = 5.0;
static CGFloat const RotYFirstLowerBound = -3.0;
static CGFloat const RotYFirstUpperBound = 1.0;
static CGFloat const RotZFirstLowerBound = 5.0;
static CGFloat const RotZFirstUpperBound = 15.0;
static CGFloat const AccXFirstLowerBound = -5.0;
static CGFloat const AccXFirstUpperBound = 5.0;
static CGFloat const AccYFirstLowerBound = 0;
static CGFloat const AccYFirstUpperBound = 3.5;
static CGFloat const AccZFirstLowerBound = -1.0;
static CGFloat const AccZFirstUpperBound = 1.0;

static CGFloat const RotXSecondLowerBound = -2.5;
static CGFloat const RotXSecondUpperBound = 7.5;
static CGFloat const RotYSecondLowerBound = -3.0;
static CGFloat const RotYSecondUpperBound = 4.0;
static CGFloat const RotZSecondLowerBound = 5.0;
static CGFloat const RotZSecondUpperBound = 15.0;
static CGFloat const AccXSecondLowerBound = -5.0;
static CGFloat const AccXSecondUpperBound = 1.0;
static CGFloat const AccYSecondLowerBound = -2.0;
static CGFloat const AccYSecondUpperBound = 3.0;
static CGFloat const AccZSecondLowerBound = -2.5;
static CGFloat const AccZSecondUpperBound = 2.5;

static CGFloat const RotXThirdLowerBound = -5.0;
static CGFloat const RotXThirdUpperBound = 5.0;
static CGFloat const RotYThirdLowerBound = -3.0;
static CGFloat const RotYThirdUpperBound = 5.0;
static CGFloat const RotZThirdLowerBound = -2.0;
static CGFloat const RotZThirdUpperBound = 8.0;
static CGFloat const AccXThirdLowerBound = -5.0;
static CGFloat const AccXThirdUpperBound = -1.0;
static CGFloat const AccYThirdLowerBound = -2.0;
static CGFloat const AccYThirdUpperBound = 1.0;
static CGFloat const AccZThirdLowerBound = -1.0;
static CGFloat const AccZThirdUpperBound = 3.0;

static CGFloat const RotXFourthLowerBound = -5.0;
static CGFloat const RotXFourthUpperBound = 1.0;
static CGFloat const RotYFourthLowerBound = -5.0;
static CGFloat const RotYFourthUpperBound = 1.5;
static CGFloat const RotZFourthLowerBound = -10.0;
static CGFloat const RotZFourthUpperBound = 0;
static CGFloat const AccXFourthLowerBound = -5.0;
static CGFloat const AccXFourthUpperBound = 0;
static CGFloat const AccYFourthLowerBound = -1.0;
static CGFloat const AccYFourthUpperBound = 1.0;
static CGFloat const AccZFourthLowerBound = -2.0;
static CGFloat const AccZFourthUpperBound = 1.0;

static CGFloat const RotXFifthLowerBound = -3.0;
static CGFloat const RotXFifthUpperBound = 1.0;
static CGFloat const RotYFifthLowerBound = -3.0;
static CGFloat const RotYFifthUpperBound = 5.0;
static CGFloat const RotZFifthLowerBound = -15.0;
static CGFloat const RotZFifthUpperBound = -3.0;
static CGFloat const AccXFifthLowerBound = -3.0;
static CGFloat const AccXFifthUpperBound = 0;
static CGFloat const AccYFifthLowerBound = -1.0;
static CGFloat const AccYFifthUpperBound = 3.0;
static CGFloat const AccZFifthLowerBound = -2.0;
static CGFloat const AccZFifthUpperBound = 1.0;

@interface SLKDeviceMotion()

@property (nonatomic) SLKNextMotionSignaturePoints currentNextMotionSignaturePoint;
@property (nonatomic) SLKBackMotionSignaturePoints currentBackMotionSignaturePoint;

@end

@implementation SLKDeviceMotion

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.currentNextMotionSignaturePoint = SLKNextMotionNotSignaturePoint;
    }
    
    return self;
}

#pragma mark - Motion Conditions

- (BOOL)isNextMotion:(CMDeviceMotion *)motion
{
    CMRotationRate rotation = motion.rotationRate;
    CMAcceleration acceleration = motion.userAcceleration;
    BOOL rotXConditionPassed = NO;
    BOOL rotYConditionPassed = NO;
    BOOL rotZConditionPassed = NO;
    BOOL accXConditionPassed = NO;
    BOOL accYConditionPassed = NO;
    BOOL accZConditionPassed = NO;
    NSLog(@"Checking NEXT for condition: %d", self.currentNextMotionSignaturePoint + 1);
    
    switch (self.currentNextMotionSignaturePoint) {
        case SLKNextMotionNotSignaturePoint:
            rotXConditionPassed = [self isMotionData:rotation.x greaterThanOrEqualToLowerBound:RotXFirstLowerBound lessThanUpperBound:RotXFirstUpperBound];
            rotYConditionPassed = [self isMotionData:rotation.y greaterThanOrEqualToLowerBound:RotYFirstLowerBound lessThanUpperBound:RotYFirstUpperBound];
            rotZConditionPassed = [self isMotionData:rotation.z greaterThanOrEqualToLowerBound:RotZFirstLowerBound lessThanUpperBound:RotZFirstUpperBound];
            accXConditionPassed = [self isMotionData:acceleration.x greaterThanOrEqualToLowerBound:AccXFirstLowerBound lessThanUpperBound:AccXFirstUpperBound];
            accYConditionPassed = [self isMotionData:acceleration.y greaterThanOrEqualToLowerBound:AccYFirstLowerBound lessThanUpperBound:AccYFirstUpperBound];
            accZConditionPassed = [self isMotionData:acceleration.z greaterThanOrEqualToLowerBound:AccZFirstLowerBound lessThanUpperBound:AccZFirstUpperBound];
            if (rotXConditionPassed && rotYConditionPassed && rotZConditionPassed && accXConditionPassed && accYConditionPassed && accZConditionPassed) {
                self.currentNextMotionSignaturePoint = SLKNextMotionStartPoint;
            } else {
                self.currentNextMotionSignaturePoint = SLKNextMotionNotSignaturePoint;
            }
            return NO;
        case SLKNextMotionStartPoint:
            rotXConditionPassed = [self isMotionData:rotation.x greaterThanOrEqualToLowerBound:RotXSecondLowerBound lessThanUpperBound:RotXSecondUpperBound];
            rotYConditionPassed = [self isMotionData:rotation.y greaterThanOrEqualToLowerBound:RotYSecondLowerBound lessThanUpperBound:RotYSecondUpperBound];
            rotZConditionPassed = [self isMotionData:rotation.z greaterThanOrEqualToLowerBound:RotZSecondLowerBound lessThanUpperBound:RotZSecondUpperBound];
            accXConditionPassed = [self isMotionData:acceleration.x greaterThanOrEqualToLowerBound:AccXSecondLowerBound lessThanUpperBound:AccXSecondUpperBound];
            accYConditionPassed = [self isMotionData:acceleration.y greaterThanOrEqualToLowerBound:AccYSecondLowerBound lessThanUpperBound:AccYSecondUpperBound];
            accZConditionPassed = [self isMotionData:acceleration.z greaterThanOrEqualToLowerBound:AccZSecondLowerBound lessThanUpperBound:AccZSecondUpperBound];
            if (rotXConditionPassed && rotYConditionPassed && rotZConditionPassed && accXConditionPassed && accYConditionPassed && accZConditionPassed) {
                self.currentNextMotionSignaturePoint = SLKNextMotionHighPoint;
            } else {
                self.currentNextMotionSignaturePoint = SLKNextMotionNotSignaturePoint;
            }
            return NO;
        case SLKNextMotionHighPoint:
            rotXConditionPassed = [self isMotionData:rotation.x greaterThanOrEqualToLowerBound:RotXThirdLowerBound lessThanUpperBound:RotXThirdUpperBound];
            rotYConditionPassed = [self isMotionData:rotation.y greaterThanOrEqualToLowerBound:RotYThirdLowerBound lessThanUpperBound:RotYThirdUpperBound];
            rotZConditionPassed = [self isMotionData:rotation.z greaterThanOrEqualToLowerBound:RotZThirdLowerBound lessThanUpperBound:RotZThirdUpperBound];
            accXConditionPassed = [self isMotionData:acceleration.x greaterThanOrEqualToLowerBound:AccXThirdLowerBound lessThanUpperBound:AccXThirdUpperBound];
            accYConditionPassed = [self isMotionData:acceleration.y greaterThanOrEqualToLowerBound:AccYThirdLowerBound lessThanUpperBound:AccYThirdUpperBound];
            accZConditionPassed = [self isMotionData:acceleration.z greaterThanOrEqualToLowerBound:AccZThirdLowerBound lessThanUpperBound:AccZThirdUpperBound];
            if (rotXConditionPassed && rotYConditionPassed && rotZConditionPassed && accXConditionPassed && accYConditionPassed && accZConditionPassed) {
                self.currentNextMotionSignaturePoint = SLKNextMotionDecreasingRotZPoint;
            } else {
                self.currentNextMotionSignaturePoint = SLKNextMotionNotSignaturePoint;
            }
            return NO;
        case SLKNextMotionDecreasingRotZPoint:
            rotXConditionPassed = [self isMotionData:rotation.x greaterThanOrEqualToLowerBound:RotXFourthLowerBound lessThanUpperBound:RotXFourthUpperBound];
            rotYConditionPassed = [self isMotionData:rotation.y greaterThanOrEqualToLowerBound:RotYFourthLowerBound lessThanUpperBound:RotYFourthUpperBound];
            rotZConditionPassed = [self isMotionData:rotation.z greaterThanOrEqualToLowerBound:RotZFourthLowerBound lessThanUpperBound:RotZFourthUpperBound];
            accXConditionPassed = [self isMotionData:acceleration.x greaterThanOrEqualToLowerBound:AccXFourthLowerBound lessThanUpperBound:AccXFourthUpperBound];
            accYConditionPassed = [self isMotionData:acceleration.y greaterThanOrEqualToLowerBound:AccYFourthLowerBound lessThanUpperBound:AccYFourthUpperBound];
            accZConditionPassed = [self isMotionData:acceleration.z greaterThanOrEqualToLowerBound:AccZFourthLowerBound lessThanUpperBound:AccZFourthUpperBound];
            if (rotXConditionPassed && rotYConditionPassed && rotZConditionPassed && accXConditionPassed && accYConditionPassed && accZConditionPassed) {
                self.currentNextMotionSignaturePoint = SLKNextMotionNegativeRotZPoint;
            } else {
                self.currentNextMotionSignaturePoint = SLKNextMotionNotSignaturePoint;
            }
            return NO;
        case SLKNextMotionNegativeRotZPoint:
            rotXConditionPassed = [self isMotionData:rotation.x greaterThanOrEqualToLowerBound:RotXFifthLowerBound lessThanUpperBound:RotXFifthUpperBound];
            rotYConditionPassed = [self isMotionData:rotation.y greaterThanOrEqualToLowerBound:RotYFifthLowerBound lessThanUpperBound:RotYFifthUpperBound];
            rotZConditionPassed = [self isMotionData:rotation.z greaterThanOrEqualToLowerBound:RotZFifthLowerBound lessThanUpperBound:RotZFifthUpperBound];
            accXConditionPassed = [self isMotionData:acceleration.x greaterThanOrEqualToLowerBound:AccXFifthLowerBound lessThanUpperBound:AccXFifthUpperBound];
            accYConditionPassed = [self isMotionData:acceleration.y greaterThanOrEqualToLowerBound:AccYFifthLowerBound lessThanUpperBound:AccYFifthUpperBound];
            accZConditionPassed = [self isMotionData:acceleration.z greaterThanOrEqualToLowerBound:AccZFifthLowerBound lessThanUpperBound:AccZFifthUpperBound];
            self.currentNextMotionSignaturePoint = SLKNextMotionNotSignaturePoint;
            if (rotXConditionPassed && rotYConditionPassed && rotZConditionPassed && accXConditionPassed && accYConditionPassed && accZConditionPassed) {
                return YES;
            }
        default:
            return NO;
    }
}

- (BOOL)isBackMotion:(CMDeviceMotion *)motion
{
//    NSLog(@"rotX %d rotY %d rotZ %d accX %d accY %d accZ %d", rotXConditionPassed, rotYConditionPassed, rotZConditionPassed, accXConditionPassed, accYConditionPassed, accZConditionPassed);
    
    return NO;
}

#pragma mark - Comparison

- (BOOL)isMotionData:(CGFloat)motionData greaterThanOrEqualToLowerBound:(CGFloat)lowerBound lessThanUpperBound:(CGFloat)upperBound
{
    BOOL isGreaterThanOrEqual = NO;
    BOOL isLessThan = NO;
    
    if (motionData >= lowerBound) {
        isGreaterThanOrEqual = YES;
    } else {
        NSLog(@"%.1f motion is lower than lower bound: %.1f", motionData, lowerBound);
    }
    if (motionData < upperBound) {
        isLessThan = YES;
    } else {
        NSLog(@"%.1f motion is greater than upper bound: %.1f", motionData, upperBound);
    }
    
    return isGreaterThanOrEqual && isLessThan;
}


@end
