//
//  ViewController.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/19/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JARRemoteViewController.h"
#import "JARMultipeerController.h"
#import "JARMotionController.h"
#import "JARConstants.h"

@interface JARRemoteViewController () <MultipeerControllerDelegate, MotionControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIView *topSeparator;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *escButton;
@property (weak, nonatomic) IBOutlet UIButton *presentButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@end

@implementation JARRemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.multipeerController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.motionController stopGettingDeviceMotion];
    [self changeViewForState:self.multipeerController.currentState peer:self.multipeerController.currentPeer];
}

- (void)changeViewForState:(MCSessionState)state peer:(MCPeerID *)peer
{
    switch (state) {
        case MCSessionStateConnecting:
            self.statusLabel.text = [NSString stringWithFormat:@"Connecting to %@", peer.displayName];
            break;
        case MCSessionStateNotConnected:
            self.statusLabel.text = @"Not Connected";
            break;
        default:
            self.statusLabel.text = [NSString stringWithFormat:@"Connected to %@", peer.displayName];
            break;
    }
}

#pragma mark - MultipeerClient Delegate

- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer
{
    [self changeViewForState:state peer:peer];
}

#pragma mark - SLKMotionSensor Delegate

- (void)changedToProximityState:(BOOL)state
{
    if (state) {
        [self.multipeerController sendMessage:MessagePayload.mute];
    } else {
        [self.multipeerController sendMessage:MessagePayload.unmute];
    }
}

#pragma mark - IBActions

- (IBAction)tappedLeftButton:(UIButton *)leftButton
{
    [self.multipeerController sendMessage:MessagePayload.back];
}

- (IBAction)tappedRightButton:(UIButton *)rightButton
{
    [self.multipeerController sendMessage:MessagePayload.next];
}

- (IBAction)tappedESCButton:(UIButton *)escButton
{
    [self.multipeerController sendMessage:MessagePayload.esc];
}

- (IBAction)tappedPresentButton:(UIButton *)presentButton
{
    [self.multipeerController sendMessage:MessagePayload.present];
}

- (IBAction)pressedRefresh:(id)sender
{
    [self.multipeerController sendMessage:MessagePayload.restart];
    [self.multipeerController restartBrowsing];
}

- (IBAction)pressedDismissRemote:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
