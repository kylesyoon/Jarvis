//
//  SLKConditions.h
//  Jarvis
//
//  Created by Kyle Yoon on 4/9/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Signature Points




#pragma mark - Next Motion Conditions

FOUNDATION_EXPORT const struct NextMotionFirstCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} NextMotionFirstCondition;

FOUNDATION_EXPORT const struct NextMotionSecondCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} NextMotionSecondCondition;

FOUNDATION_EXPORT const struct NextMotionThirdCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} NextMotionThirdCondition;

FOUNDATION_EXPORT const struct NextMotionFourthCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} NextMotionFourthCondition;

FOUNDATION_EXPORT const struct NextMotionFifthCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} NextMotionFifthCondition;

#pragma mark - Back Motion Conditions

FOUNDATION_EXPORT const struct BackMotionFirstCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} BackMotionFirstCondition;

FOUNDATION_EXPORT const struct BackMotionSecondCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} BackMotionSecondCondition;

FOUNDATION_EXPORT const struct BackMotionThirdCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} BackMotionThirdCondition;

FOUNDATION_EXPORT const struct BackMotionFourthCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} BackMotionFourthCondition;

FOUNDATION_EXPORT const struct BackMotionFifthCondition {
    CGFloat rotXLowerBound;
    CGFloat rotXUpperBound;
    CGFloat rotYLowerBound;
    CGFloat rotYUpperBound;
    CGFloat rotZLowerBound;
    CGFloat rotZUpperBound;
    CGFloat accelXLowerBound;
    CGFloat accelXUpperBound;
    CGFloat accelYLowerBound;
    CGFloat accelYUpperBound;
    CGFloat accelZLowerBound;
    CGFloat accelZUpperBound;
} BackMotionFifthCondition;

@interface JARMotionConditions : NSObject

@end
