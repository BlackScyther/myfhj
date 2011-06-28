//
//  RootViewController.h
//  myFHJ
//
//  Created by Markus Scheucher on 26.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Three20.h"

@interface RootViewController : UIViewController {

}

- (IBAction) openNewsFeed;
- (IBAction) openEventFeed;
- (IBAction) openAgenda;
- (IBAction) openSettings;
- (IBAction) openInfo;

- (void) openAppWithTitle:(NSString*)title;

@end
