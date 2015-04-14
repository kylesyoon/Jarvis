//
//  MultipeerClient.h
//  Jarvis
//
//  Created by Kyle Yoon on 3/20/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol MultipeerControllerDelegate
/// For delegate to make view changes.
- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer;
/// For alert delegate that a peer has been found.
@optional
- (void)foundPeer:(MCPeerID *)peer forSession:(MCSession *)session;

@end

@interface JARMultipeerController : NSObject
/// Singleton.
+ (instancetype)sharedInstance;
/// Sends the message string as payload.
- (void)sendMessage:(NSString *)message;
/// Stops and starts browsing.
- (void)restartBrowsing;

@property (strong, nonatomic) MCNearbyServiceBrowser *browser;
@property (nonatomic) MCSessionState currentState;
@property (nonatomic) MCPeerID *currentPeer;
@property id<MultipeerControllerDelegate> delegate;

@end
