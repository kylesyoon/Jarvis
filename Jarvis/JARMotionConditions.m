//
//  SLKConditions.m
//  Jarvis
//
//  Created by Kyle Yoon on 4/9/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JARMotionConditions.h"

#pragma mark - Next Motion Conditions

const struct NextMotionFirstCondition NextMotionFirstCondition = {
    .rotXLowerBound = -5.0,
    .rotXUpperBound = 5.0,
    .rotYLowerBound = -3.0,
    .rotYUpperBound = 1.0,
    .rotZLowerBound = 5.0,
    .rotZUpperBound = 20.0,
    .accelXLowerBound = -5.0,
    .accelXUpperBound = 5.0,
    .accelYLowerBound = 0,
    .accelYUpperBound = 3.5,
    .accelZLowerBound = -1.0,
    .accelZUpperBound = 1.0,
};

const struct NextMotionSecondCondition NextMotionSecondCondition = {
    .rotXLowerBound = -3.5,
    .rotXUpperBound = 5.5,
    .rotYLowerBound = -3.0,
    .rotYUpperBound = 6.0,
    .rotZLowerBound = 5.0,
    .rotZUpperBound = 20.0,
    .accelXLowerBound = -6.0,
    .accelXUpperBound = 2.0,
    .accelYLowerBound = -2.0,
    .accelYUpperBound = 4.0,
    .accelZLowerBound = -2.5,
    .accelZUpperBound = 2.5,
};

const struct NextMotionThirdCondition NextMotionThirdCondition = {
    .rotXLowerBound = -3.0,
    .rotXUpperBound = 7.0,
    .rotYLowerBound = -3.0,
    .rotYUpperBound = 6.0,
    .rotZLowerBound = -2.0,
    .rotZUpperBound = 11.0,
    .accelXLowerBound = -6.0,
    .accelXUpperBound = 0.5,
    .accelYLowerBound = -2.0,
    .accelYUpperBound = 2.0,
    .accelZLowerBound = -2.0,
    .accelZUpperBound = 3.0,
};

const struct NextMotionFourthCondition NextMotionFourthCondition = {
    .rotXLowerBound = -4.0,
    .rotXUpperBound = 2.5,
    .rotYLowerBound = -5.0,
    .rotYUpperBound = 2.0,
    .rotZLowerBound = -8.0,
    .rotZUpperBound = 3.0,
    .accelXLowerBound = -5.0,
    .accelXUpperBound = 0,
    .accelYLowerBound = -1.0,
    .accelYUpperBound = 1.0,
    .accelZLowerBound = -2.0,
    .accelZUpperBound = 2.0,
};

const struct NextMotionFifthCondition NextMotionFifthCondition = {
    .rotXLowerBound = -3.0,
    .rotXUpperBound = 1.0,
    .rotYLowerBound = -3.0,
    .rotYUpperBound = 5.0,
    .rotZLowerBound = -10.0,
    .rotZUpperBound = 0,
    .accelXLowerBound = -3.0,
    .accelXUpperBound = 0,
    .accelYLowerBound = -1.0,
    .accelYUpperBound = 3.0,
    .accelZLowerBound = -2.0,
    .accelZUpperBound = 1.0,
};

#pragma mark - Back Motion Conditions

const struct BackMotionFirstCondition BackMotionFirstCondition = {
    .rotXLowerBound = -2.0,
    .rotXUpperBound = 3.0,
    .rotYLowerBound = -8.0,
    .rotYUpperBound = 5.0,
    .rotZLowerBound = -15.0,
    .rotZUpperBound = -7.0,
    .accelXLowerBound = -3.0,
    .accelXUpperBound = 0,
    .accelYLowerBound = -1.0,
    .accelYUpperBound = 2.0,
    .accelZLowerBound = -2.0,
    .accelZUpperBound = 1.0,
};

const struct BackMotionSecondCondition BackMotionSecondCondition = {
    .rotXLowerBound = -3.0,
    .rotXUpperBound = 5.0,
    .rotYLowerBound = -5.0,
    .rotYUpperBound = 3.0,
    .rotZLowerBound = -15.0,
    .rotZUpperBound = -5.0,
    .accelXLowerBound = -1.0,
    .accelXUpperBound = 3.0,
    .accelYLowerBound = 0,
    .accelYUpperBound = 3.0,
    .accelZLowerBound = -2.0,
    .accelZUpperBound = 2.0,
};

const struct BackMotionThirdCondition BackMotionThirdCondition = {
    .rotXLowerBound = -1.0,
    .rotXUpperBound = 3.0,
    .rotYLowerBound = -3.0,
    .rotYUpperBound = 2.0,
    .rotZLowerBound = -8.0,
    .rotZUpperBound = 0,
    .accelXLowerBound = 1.0,
    .accelXUpperBound = 3.0,
    .accelYLowerBound = -1.0,
    .accelYUpperBound = 2.0,
    .accelZLowerBound = -1.5,
    .accelZUpperBound = 3.0,
};

const struct BackMotionFourthCondition BackMotionFourthCondition = {
    .rotXLowerBound = -2.0,
    .rotXUpperBound = 2.0,
    .rotYLowerBound = -5.0,
    .rotYUpperBound = 5.0,
    .rotZLowerBound = -2.0,
    .rotZUpperBound = 5.0,
    .accelXLowerBound = 0,
    .accelXUpperBound = 2.0,
    .accelYLowerBound = 0,
    .accelYUpperBound = 1.0,
    .accelZLowerBound = -1.0,
    .accelZUpperBound = 1.0,
};

const struct BackMotionFifthCondition BackMotionFifthCondition = {
    .rotXLowerBound = -4.0,
    .rotXUpperBound = 1.0,
    .rotYLowerBound = 0,
    .rotYUpperBound = 4.0,
    .rotZLowerBound = 0,
    .rotZUpperBound = 7.0,
    .accelXLowerBound = -1.0,
    .accelXUpperBound = 1.0,
    .accelYLowerBound = -1.0,
    .accelYUpperBound = 1.0,
    .accelZLowerBound = -1.0,
    .accelZUpperBound = 1.0,
};

@implementation JARMotionConditions

@end
