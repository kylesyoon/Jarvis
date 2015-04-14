//
//  UIColor+Jarvis.m
//  Jarvis
//
//  Created by Kyle Yoon on 4/1/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "UIColor+Jarvis.h"

@implementation UIColor (Jarvis)

+ (UIColor *)jarvis_lightBlue
{
    return [self colorFromHexString:@"BAE4E5"];
}

+ (UIColor *)jarvis_gunMetal
{
    return [self colorFromHexString:@"262826"];
}

#pragma mark - Helpers with HEX

+ (UIColor *)colorFromHexString:(NSString *)string
{
    unsigned int hexInt = [self intFromHexString:string];
    return [UIColor colorWithRed:((CGFloat)((hexInt & 0xFF0000) >> 16))/255.0
                           green:((CGFloat)((hexInt & 0xFF00) >> 8))/255.0
                            blue:((CGFloat)(hexInt & 0xFF))/255.0
                           alpha:1];
    
}

+ (unsigned int)intFromHexString:(NSString *)string
{
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexInt];
    return hexInt;
}

@end
