//
//  MessageConstants.h
//  Jarvis
//
//  Created by Kyle Yoon on 4/1/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const struct MessagePayload {
    __unsafe_unretained NSString *next;
    __unsafe_unretained NSString *strongNext;
    __unsafe_unretained NSString *back;
    __unsafe_unretained NSString *present;
    __unsafe_unretained NSString *esc;
    __unsafe_unretained NSString *mute;
    __unsafe_unretained NSString *unmute;
    __unsafe_unretained NSString *restart;
} MessagePayload;

FOUNDATION_EXPORT const CGFloat ninetyDegrees;
FOUNDATION_EXPORT const CGFloat thirtyDegrees;
FOUNDATION_EXPORT const CGFloat motionTriggerDelay;

@interface JARConstants : NSObject

@end
