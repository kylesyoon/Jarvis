//
//  MotionViewController.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "MotionViewController.h"
#import "JVSMultipeerClient.h"
#import "JVSMotionSensor.h"

@interface MotionViewController () <MultipeerDelegate, JVSMotionSensorDelegate>

@property (weak, nonatomic) IBOutlet UIButton *remoteButton;
@property (strong, nonatomic) JVSMultipeerClient *multipeer;
@property (strong, nonatomic) JVSMotionSensor *motionSensor;
@property (strong, nonatomic) UIView *circle;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.circle.center = self.view.center;
    self.circle.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1.0];
    self.circle.layer.cornerRadius = 50;

    [self.view addSubview:self.circle];
    
    self.multipeer = [JVSMultipeerClient sharedInstance];
    self.multipeer.delegate = self;
    
    self.motionSensor = [JVSMotionSensor sharedInstance];
    self.motionSensor.delegate = self;
    [self.motionSensor startGettingDeviceMotion];

}

- (void)startPulsingCircle
{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:nil selector:@selector(pulseCircle) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)pulseCircle
{
    [UIView animateKeyframesWithDuration:1 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            self.circle.alpha = 0.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            self.circle.alpha = 1.0;
        }];
    } completion:^(BOOL finished) {
        // Completion
    }];
}

- (void)stopPulsingCircle
{
    [self.timer invalidate];
}

- (void)animateCircleForMessage:(NSString *)message
{
    CGPoint originalCenter = self.circle.center;
    if ([message isEqualToString:JVSNextMessage]) {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circle.center = CGPointMake(0, self.circle.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.circle.center = originalCenter;
            } completion:nil];
        }];
    } else if ([message isEqualToString:JVSBackMessage]) {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.circle.center = CGPointMake(self.view.frame.size.width, self.circle.center.y);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.circle.center = originalCenter;
            } completion:nil];
        }];
    } else if ([message isEqualToString:JVSESCMessage]) {
        CGRect originalFrame = self.circle.frame;
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // Need to make it so that it grows from the center.
//            CGRect biggerFrame = originalFrame;
//            biggerFrame.size.width += 50;
//            biggerFrame.size.height += 50;
//            self.circle.layer.cornerRadius = 75;
//            self.circle.frame = biggerFrame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
//                self.circle.layer.cornerRadius = 50;
//                self.circle.frame = originalFrame;
            } completion:nil];
        }];
    }
}

#pragma mark - JVSMotionSensor Delegate

- (void)sendMessage:(NSString *)message
{
    [self.multipeer sendMessage:message];
    [self animateCircleForMessage:message];
}

#pragma mark - Multipeer Delegate

- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer
{
    switch (state) {
        case MCSessionStateConnecting:
            [self startPulsingCircle];
            break;
        case MCSessionStateNotConnected:
            self.circle.backgroundColor = [UIColor colorWithRed:0.0 green:180.0/255.0 blue:1.0 alpha:1.0];
            [self stopPulsingCircle];
            break;
        default:
            [self stopPulsingCircle];
            self.circle.backgroundColor = [UIColor colorWithRed:0.0 green:180.0/255.0 blue:1.0 alpha:1.0];
            [self.remoteButton setTitleColor:[UIColor colorWithRed:0.0 green:180.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            break;
    }
}

@end
