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
#import "UIColor+Jarvis.h"

@interface JARRemoteViewController () <MultipeerDelegate, MotionSensorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;
@property (weak, nonatomic) IBOutlet UIView *topSeparator;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *escButton;
@property (weak, nonatomic) IBOutlet UIButton *presentButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (strong, nonatomic) JARMultipeerController *multipeerClient;
@property (strong, nonatomic) JARMotionController *motionSensor;
@property (strong, nonatomic) MCPeerID *peer;

@end

@implementation JARRemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.multipeerClient = [JARMultipeerController sharedInstance];
    self.multipeerClient.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self changeViewForState:self.multipeerClient.currentState peer:self.multipeerClient.currentPeer];
}

- (void)changeViewForState:(MCSessionState)state peer:(MCPeerID *)peer
{
    UIColor *color = [[UIColor alloc] init];
    switch (state) {
        case MCSessionStateConnecting:
            self.statusLabel.text = [NSString stringWithFormat:@"Connecting to %@", peer.displayName];
            color = nil;
            break;
        case MCSessionStateNotConnected:
            self.statusLabel.text = @"Not Connected";
            color = [UIColor jarvis_primaryRed];
            break;
        default:
            self.statusLabel.text = [NSString stringWithFormat:@"Connected to %@", peer.displayName];
            color = [UIColor jarvis_primaryBlue];
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
        [self.refreshButton setTitleColor:color forState:UIControlStateNormal];
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

- (IBAction)pressedRefresh:(id)sender
{
    [self.multipeerClient sendMessage:MessagePayload.restart];
    [self.multipeerClient restartBrowsing];
}

- (IBAction)pressedDismissRemote:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
