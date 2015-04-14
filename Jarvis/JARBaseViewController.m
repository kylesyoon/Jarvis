//
//  JARBaseViewController.m
//  
//
//  Created by Kyle Yoon on 4/13/15.
//
//

#import "JARBaseViewController.h"

@interface JARBaseViewController()

@end

@implementation JARBaseViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     
     self.multipeerController = [JARMultipeerController sharedInstance];
     self.motionController = [JARMotionController sharedInstance];
}

- (void)foundPeer:(MCPeerID *)peer forSession:(MCSession *)session
{
     UIAlertController *foundPeerAlert = [UIAlertController alertControllerWithTitle:@"Connection Available"
                                                                             message:[NSString stringWithFormat:@"Would you like to connect to %@?", peer.displayName]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
     UIAlertAction *connectAction = [UIAlertAction actionWithTitle:@"Connect"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
          [self.multipeerController.browser invitePeer:peer
                                             toSession:session
                                           withContext:nil
                                               timeout:30];
     }];
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction *action) {
          [foundPeerAlert dismissViewControllerAnimated:YES completion:nil];
     }];
     [foundPeerAlert addAction:connectAction];
     [foundPeerAlert addAction:cancelAction];
     [self presentViewController:foundPeerAlert animated:YES completion:nil];
}

@end
