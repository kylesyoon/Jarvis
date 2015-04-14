//
//  JARBaseViewController.h
//  
//
//  Created by Kyle Yoon on 4/13/15.
//
//

#import <UIKit/UIKit.h>
#import "JARMultipeerController.h"
#import "JARMotionController.h"

@interface JARBaseViewController : UIViewController

@property (strong, nonatomic) JARMultipeerController *multipeerController;
@property (strong, nonatomic) JARMotionController *motionController;
/// Delegate method for JARMultipeerController. Will present an alert when peer is found.
//- (void)foundPeer:(MCPeerID *)peer forSession:(MCSession *)session;

@end
