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
#import "JARConstants.h"
#import "JARConnectedGradientView.h"
#import "JARMotionGradientView.h"

@interface JARMotionViewController () <MultipeerControllerDelegate, MotionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *remoteButton;
@property (weak, nonatomic) IBOutlet UILabel *deviceLabel;
@property (strong, nonatomic) JARConnectedGradientView *connectedGradient;
@property (strong, nonatomic) JARMotionGradientView *motionGradient;

@end

@implementation JARMotionViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.multipeerController.delegate = self;
     self.motionController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];

     [self.motionController startGettingDeviceMotion];
     
     if (self.multipeerController.currentPeer) {
          self.deviceLabel.text = self.multipeerController.currentPeer.displayName;
     }
}

- (void)viewDidLayoutSubviews
{
     [super viewDidLayoutSubviews];
     
     self.connectedGradient = [[JARConnectedGradientView alloc] initWithFrame:self.view.frame];
     self.connectedGradient.alpha = 0.0;
     [self.view addSubview:self.connectedGradient];
     
     [self.view bringSubviewToFront:self.remoteButton];
     [self.view bringSubviewToFront:self.deviceLabel];
     
     self.motionGradient = [[JARMotionGradientView alloc] initWithFrame:self.view.frame];
     self.motionGradient.alpha = 0.0;
     [self.view addSubview:self.motionGradient];
}

#pragma mark - Motion Controller Delegate

- (void)detectedMotion:(NSString *)motion
{
     [self showMotionGradient];
     [self.multipeerController sendMessage:motion];
}

- (void)changedToProximityState:(BOOL)state
{
     if (state) {
          [self.multipeerController sendMessage:MessagePayload.mute];
     } else {
          [self.multipeerController sendMessage:MessagePayload.unmute];
     }
}

#pragma mark - Multipeer Controller Delegate

- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer
{
     switch (state) {
          case MCSessionStateConnecting:
               self.deviceLabel.text = @"Connecting";
               break;
          case MCSessionStateNotConnected:
               self.deviceLabel.text = @"Not Connected";
               [self hideConnectedGradient];
               break;
          case MCSessionStateConnected:
               self.deviceLabel.text = peer.displayName;
               [self showConnectedGradient];
               break;
     }
}

#pragma mark - Animation

- (void)showConnectedGradient
{
     [UIView animateWithDuration:0.5
                           delay:0.0
                         options:UIViewAnimationOptionCurveEaseOut
                      animations:^{
          self.connectedGradient.alpha = 1.0;
     } completion:nil];
}

- (void)hideConnectedGradient
{
     [UIView animateWithDuration:0.5
                           delay:0.0
                         options:UIViewAnimationOptionCurveEaseOut
                      animations:^{
          self.connectedGradient.alpha = 0.0;
     } completion:nil];
}

- (void)showMotionGradient
{
     [UIView animateWithDuration:0.5 
                           delay:0.0
                         options:UIViewAnimationOptionCurveEaseOut
                      animations:^{
          self.motionGradient.alpha = 1.0;
     } completion:^(BOOL finished) {
          [UIView animateWithDuration:0.5
                                delay:0.0
                              options:UIViewAnimationOptionCurveEaseIn
                           animations:^{
               self.motionGradient.alpha = 0.0;
          } completion:nil];
     }];
}

@end
