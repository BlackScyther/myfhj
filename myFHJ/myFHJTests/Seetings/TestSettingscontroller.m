//
//  TestSettingscontroller.m
//  myFHJ
//
//  Created by Markus Scheucher on 27.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestSettingscontroller.h"


@implementation TestSettingscontroller

- (void) setUp 
{
    settingsController = [[SettingsController alloc] init];
}

- (void) tearDown
{
    [settingsController release];
}

@end
