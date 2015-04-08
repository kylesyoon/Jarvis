//
//  MultipeerClient.h
//  Jarvis
//
//  Created by Kyle Yoon on 3/20/15.
//  Copyright (c) 2015 Kyle Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol MultipeerDelegate
/// For delegate to make view changes.
- (void)stateChanged:(MCSessionState)state peer:(MCPeerID *)peer;

@end

@interface SLKMultipeerClient : NSObject

@property (nonatomic) MCSessionState currentState;
@property id<MultipeerDelegate> delegate;
/// Singleton.
+ (instancetype)sharedInstance;
/// Sends the message string as payload.
- (void)sendMessage:(NSString *)message;

@end
