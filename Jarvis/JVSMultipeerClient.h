//
//  MultipeerClient.h
//  Jarvis
//
//  Created by Kyle Yoon on 3/20/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

FOUNDATION_EXPORT NSString *const JVSNextMessage;
FOUNDATION_EXPORT NSString *const JVSBackMessage;
FOUNDATION_EXPORT NSString *const JVSESCMessage;
FOUNDATION_EXPORT NSString *const JVSMuteMessage;
FOUNDATION_EXPORT NSString *const JVSUnmuteMessage;

@protocol MultipeerDelegate

- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer;

@end

@interface JVSMultipeerClient : NSObject

@property id<MultipeerDelegate> delegate;

//- (void)startBrowsing;
//- (void)stopBrowsing;

+ (instancetype)sharedInstance;
- (void)sendMessage:(NSString *)message;

@end
