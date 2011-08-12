//
//  myFHJAppDelegate.h
//  myFHJ
//
//  Created by Markus Scheucher on 26.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
///Users/BlackScyther/Dropbox/privat/Bakk2/TeX/Bakk2/output/document.pdf

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (void)registerDefaults;

@end
