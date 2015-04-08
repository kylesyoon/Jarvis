//
//  ViewController.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/19/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "SLKRemoteViewController.h"
#import "SLKMultipeerClient.h"
#import "SLKMotionSensor.h"
#import "SLKConstants.h"
#import "UIColor+Slick.h"

@interface SLKRemoteViewController () <MultipeerDelegate, MotionSensorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIView *topSeparator;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *escButton;
@property (weak, nonatomic) IBOutlet UIButton *presentButton;

@property (strong, nonatomic) SLKMultipeerClient *multipeerClient;
@property (strong, nonatomic) SLKMotionSensor *motionSensor;

@end

@implementation SLKRemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.multipeerClient = [SLKMultipeerClient sharedInstance];
    self.multipeerClient.delegate = self;
    
    self.motionSensor = [SLKMotionSensor sharedInstance];
    self.motionSensor.delegate = self;
    [self.motionSensor startGettingDeviceMotion];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self changeViewForState:self.multipeerClient.currentState];
}

- (void)changeViewForState:(MCSessionState)state
{
    UIColor *color = [[UIColor alloc] init];
    switch (state) {
        case MCSessionStateConnecting:
            self.statusLabel.text = @"Connecting";
            color = nil;
            break;
        case MCSessionStateNotConnected:
            self.statusLabel.text = @"Not Connected";
            color = [UIColor slick_primaryRed];
            break;
        default:
            self.statusLabel.text = @"Connected";
            color = [UIColor slick_primaryBlue];
            break;
    }
    if (color) {
        self.statusLabel.textColor = color;
        self.topSeparator.backgroundColor = color;
        self.escButton.backgroundColor = color;
        self.presentButton.backgroundColor = color;
        [self.dismissButton setTitleColor:color forState:UIControlStateNormal];
        [self.leftArrowButton setTitleColor:color forState:UIControlStateNormal];
        [self.rightArrowButton setTitleColor:color forState:UIControlStateNormal];
    }
}

#pragma mark - MultipeerClient Delegate

- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer
{
    [self changeViewForState:state];
}

#pragma mark - SLKMotionSensor Delegate

- (void)changedToProximityState:(BOOL)state
{
    if (state) {
        [self.multipeerClient sendMessage:MessagePayload.mute];
    } else {
        [self.multipeerClient sendMessage:MessagePayload.unmute];
    }
}
#pragma mark - IBActions

- (IBAction)tappedLeftButton:(UIButton *)leftButton
{
    [self.multipeerClient sendMessage:MessagePayload.back];
}

- (IBAction)tappedRightButton:(UIButton *)rightButton
{
    [self.multipeerClient sendMessage:MessagePayload.next];
}

- (IBAction)tappedESCButton:(UIButton *)escButton
{
    [self.multipeerClient sendMessage:MessagePayload.esc];
}

- (IBAction)tappedPresentButton:(UIButton *)presentButton
{
    [self.multipeerClient sendMessage:MessagePayload.present];
}

- (IBAction)pressedDismissRemote:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
