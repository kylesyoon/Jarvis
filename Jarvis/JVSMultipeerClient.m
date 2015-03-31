//
//  MultipeerClient.m
//  Jarvis
//
//  Created by Kyle Yoon on 3/20/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import "JVSMultipeerClient.h"

static NSString *const JARVISServiceType = @"jarvis-service";
NSString *const JVSNextMessage = @"NEXT";
NSString *const JVSBackMessage = @"BACK";
NSString *const JVSESCMessage = @"ESC";
NSString *const JVSMuteMessage = @"MUTE";
NSString *const JVSUnmuteMessage = @"UNMUTE";

@interface JVSMultipeerClient() <MCNearbyServiceBrowserDelegate, MCSessionDelegate>

@property (strong, nonatomic) MCPeerID *localPeerID;
@property (strong, nonatomic) MCNearbyServiceBrowser *browser;
@property (strong, nonatomic) MCSession *session;
@property (strong, nonatomic) NSArray *peers;

@end

@implementation JVSMultipeerClient

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    self.localPeerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
    
    if (!self.browser) {
        self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.localPeerID serviceType:JARVISServiceType];
    }

    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
    NSLog(@"BROWSER INITIALIZED: %@", self.browser);
    return self;
}

//- (void)stopBrowsing
//{
//    self.browser.delegate = nil;
//    [self.browser stopBrowsingForPeers];
//    NSLog(@"Stopped browsing");
//}

#pragma mark - Message sending

- (void)sendMessage:(NSString *)message
{
    NSLog(@"Sending message %@ to peer %@", message, self.peers);
    
    NSData *payload = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    [self.session sendData:payload
                   toPeers:self.peers
                  withMode:MCSessionSendDataReliable
                     error:&error];
}

#pragma mark - MCNearbyServiceBrowserDelegate

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    if (self.session == nil) {
        self.session = [[MCSession alloc] initWithPeer:self.localPeerID];
        self.session.delegate = self;
    }
    NSLog(@"MCNearbyServiceBrowser - FOUND PEER: %@", peerID);
    self.peers = [NSArray arrayWithObject:peerID];
    
    [browser invitePeer:peerID toSession:self.session withContext:nil timeout:30];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID
{
    NSLog(@"Lost peer: %@", peerID);
}

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    // Is there a way to override the state setter instead.
    [self.delegate stateChanged:state peer:peerID];

    switch (state) {
        case MCSessionStateNotConnected:
            NSLog(@"MCSessionDelegate: NOT CONNECTED: %@", peerID);
            break;
        case MCSessionStateConnecting:
            NSLog(@"MCSessionDelegate: CONNECTING, %@", peerID);
            break;
        default:
            NSLog(@"MCSessionDelegate: CONNECTED, %@", peerID);
            // Maybe alert to show that it started.
            break;
    }
}

// Boiler plate stuff
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    // No data coming this way... yet.
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    NSLog(@"Did start receiving resource: %@ from peer: %@ with progress:%@", resourceName, peerID, progress);
}

-(void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    NSLog(@"Did finish receiving resource: %@ from peer: %@ at URL: %@ with error :%@", resourceName, peerID, localURL, error);
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    NSLog(@"Did receive stream: %@ with name: %@ from peer:%@", stream, streamName, peerID);
}

- (void)session:(MCSession *)session didReceiveCertificate:(NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL))certificateHandler
{
    certificateHandler(YES);
}

@end
