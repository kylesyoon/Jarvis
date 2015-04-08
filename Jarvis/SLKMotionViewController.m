//
//  MotionViewController.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "SLKMotionViewController.h"
#import "SLKMultipeerClient.h"
#import "SLKMotionSensor.h"
#import "SLKMotionCircleView.h"
#import "SLKConstants.h"
#import "UIColor+Slick.h"

@interface SLKMotionViewController () <MultipeerDelegate, MotionSensorDelegate>

@property (weak, nonatomic) IBOutlet UIButton *remoteButton;
@property (weak, nonatomic) IBOutlet UIView *separator;
@property (weak, nonatomic) IBOutlet SLKMotionCircleView *circle;
@property (strong, nonatomic) SLKMultipeerClient *multipeer;
@property (strong, nonatomic) SLKMotionSensor *motionSensor;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation SLKMotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.multipeer = [SLKMultipeerClient sharedInstance];
    self.multipeer.delegate = self;
    
    self.motionSensor = [SLKMotionSensor sharedInstance];
    self.motionSensor.delegate = self;
    [self.motionSensor startGettingDeviceMotion];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self changeViewsColorForState:self.multipeer.currentState];
}

#pragma mark - Animation

- (void)animateCircleForMessage:(NSString *)message
{
    CGPoint originalCenter = self.circle.center;
    if ([message isEqualToString:MessagePayload.next]) {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:2.0 initialSpringVelocity:3.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circle.center = CGPointMake(0, self.circle.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:3.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.circle.center = originalCenter;
            } completion:nil];
        }];
    } else if ([message isEqualToString:MessagePayload.back]) {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:2.0 initialSpringVelocity:3.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circle.center = CGPointMake(self.view.frame.size.width, self.circle.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:3.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.circle.center = originalCenter;
            } completion:nil];
        }];
    } else if ([message isEqualToString:MessagePayload.esc]) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circle.transform = CGAffineTransformScale(self.circle.transform, .1, .1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.circle.transform = CGAffineTransformScale(self.circle.transform, 10, 10);
            } completion:nil];
        }];
    } else if ([message isEqualToString:MessagePayload.present]) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circle.transform = CGAffineTransformScale(self.circle.transform, 10, 10);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.circle.transform = CGAffineTransformScale(self.circle.transform, .1, .1);
            } completion:nil];
        }];
    }
}

#pragma mark - JVSMotion Delegate

- (void)detectedMotion:(NSString *)motion
{
     [self.multipeer sendMessage:motion];
     [self animateCircleForMessage:motion];
}

- (void)changedToProximityState:(BOOL)state
{
     if (state) {
          [self.multipeer sendMessage:MessagePayload.mute];
     } else {
          [self.multipeer sendMessage:MessagePayload.unmute];
     }
}

#pragma mark - MultipeerClient Delegate

- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer
{
    [self changeViewsColorForState:state];
}

#pragma mark - Convenience

- (void)changeViewsColorForState:(MCSessionState)state
{
    UIColor *color = [[UIColor alloc] init];
    switch (state) {
        case MCSessionStateConnecting:
            color = nil;
            break;
        case MCSessionStateNotConnected:
            color = [UIColor slick_primaryRed];
            break;
        default:
            color = [UIColor slick_primaryBlue];
            break;
    }
    if (color) {
        [self.remoteButton setTitleColor:color forState:UIControlStateNormal];
        self.separator.backgroundColor = color;
        self.circle.backgroundColor = color;
    }
}

- (IBAction)getLinks:(id)sender
{
     [self.multipeer sendMessage:@"links"];
}

@end
