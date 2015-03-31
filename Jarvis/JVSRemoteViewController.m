//
//  ViewController.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/19/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JVSRemoteViewController.h"
#import "JVSMultipeerClient.h"
#import "JVSMotionSensor.h"

@interface JVSRemoteViewController () <MultipeerDelegate, JVSMotionSensorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (strong, nonatomic) JVSMultipeerClient *multipeerClient;
@property (strong, nonatomic) JVSMotionSensor *motionSensor;

@end

@implementation JVSRemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.multipeerClient = [JVSMultipeerClient sharedInstance];
    self.multipeerClient.delegate = self;
    
    self.motionSensor = [JVSMotionSensor sharedInstance];
    self.motionSensor.delegate = self;
    [self.motionSensor startGettingDeviceMotion];
}

- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer
{
    switch (state) {
        case MCSessionStateConnecting:
            self.statusLabel.text = @"Connecting";
            break;
        case MCSessionStateNotConnected:
            self.statusLabel.text = @"Not Connected";
            break;
        default:
            self.statusLabel.text = @"Connected";
            break;
    }
}

#pragma mark - JVSMotionSensor Delegate

- (void)sendMessage:(NSString *)message
{
    [self.multipeerClient sendMessage:message];
}

#pragma mark - IBActions

- (IBAction)tappedLeftButton:(UIButton *)leftButton
{
    [self.multipeerClient sendMessage:JVSBackMessage];
}

- (IBAction)tappedRightButton:(UIButton *)rightButton
{
    [self.multipeerClient sendMessage:JVSNextMessage];
}

- (IBAction)tappedESCButton:(UIButton *)escButton
{
    [self.multipeerClient sendMessage:JVSESCMessage];
}

- (IBAction)tappedMuteButton:(UIButton *)muteButton
{
    [self.multipeerClient sendMessage:JVSMuteMessage];
}

- (IBAction)pressedDismissRemote:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
