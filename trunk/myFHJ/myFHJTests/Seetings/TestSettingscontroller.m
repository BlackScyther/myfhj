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
    firstName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userFirstname"];
    lastName = [[NSUserDefaults standardUserDefaults] stringForKey:@"userLastname"];
}

- (void) tearDown
{
    [settingsController release];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:firstName forKey:@"userFirstname"];
    [defaults setObject:lastName forKey:@"userLastname"];
}


- (void) testSaveText 
{
    UITextField *txt = [[UITextField alloc] init];
    txt.text = @"test";
    txt.tag = 1;
    
    [settingsController saveText:txt];
 
    STAssertTrue([[[NSUserDefaults standardUserDefaults] stringForKey:@"userFirstname"] isEqualToString:@"test"], @"");
}

@end
