//
//  MotionViewController.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/31/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JARMotionViewController.h"
#import "JARMultipeerController.h"
#import "JARMotionController.h"
#import "SLKMotionCircleView.h"
#import "JARConstants.h"
#import "UIColor+Jarvis.h"

@interface JARMotionViewController () <MultipeerDelegate, MotionSensorDelegate>

@property (weak, nonatomic) IBOutlet UIButton *remoteButton;
@property (weak, nonatomic) IBOutlet UIView *separator;
@property (weak, nonatomic) IBOutlet UILabel *deviceLabel;
@property (weak, nonatomic) IBOutlet SLKMotionCircleView *circle;
@property (strong, nonatomic) JARMultipeerController *multipeer;
@property (strong, nonatomic) JARMotionController *motionSensor;

@end

@implementation JARMotionViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.multipeer = [JARMultipeerController sharedInstance];
     self.multipeer.delegate = self;
     
     self.motionSensor = [JARMotionController sharedInstance];
     self.motionSensor.delegate = self;
     [self.motionSensor startGettingDeviceMotion];
     
     self.deviceLabel.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     
     [self changeViewsColorForState:self.multipeer.currentState];
     if (self.multipeer.currentPeer) {
          self.deviceLabel.text = self.multipeer.currentPeer.displayName;
     }
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
     if (peer) {
          self.deviceLabel.text = peer.displayName;
     }
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
               color = [UIColor jarvis_primaryRed];
               self.deviceLabel.hidden = YES;
               break;
          default:
               color = [UIColor jarvis_primaryBlue];
               self.deviceLabel.hidden = NO;
               break;
     }
     if (color) {
          [self.remoteButton setTitleColor:color forState:UIControlStateNormal];
          self.separator.backgroundColor = color;
          self.circle.backgroundColor = color;
          self.deviceLabel.textColor = color;
     }
}

@end
