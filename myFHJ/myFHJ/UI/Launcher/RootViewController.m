//
//  RootViewController.m
//  myFHJ
//
//  Created by Markus Scheucher on 26.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "FeedTableController.h"
#import "AgendaTableController.h"
#import "SettingsController.h"
#import "InfoViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"launcher.title", @"title");
    
    BOOL isFistLaunch = ![[NSUserDefaults standardUserDefaults] boolForKey:@"disclaimerAccepted"];
    if (isFistLaunch) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disclaimer" 
                                                        message:NSLocalizedString(@"app.disclaimer", @"Disclaimer")
                                                       delegate:nil 
                                              cancelButtonTitle:@"Akzeptieren" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"disclaimerAccepted"];
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark actions

- (IBAction) openNewsFeed
{
    [self openAppWithTitle:@"News"];
}

- (IBAction) openEventFeed 
{
    [self openAppWithTitle:@"Events"];
}

- (IBAction) openAgenda 
{
    [self openAppWithTitle:@"Agenda"];
}

- (IBAction) openSettings 
{
    [self openAppWithTitle:@"Settings"];
}

- (IBAction) openInfo
{
    [self openAppWithTitle:@"Info"];
}

- (void) openAppWithTitle:(NSString*)title 
{
    UIViewController *controller = nil;
    
    if ([title isEqualToString:@"News"] || [title isEqualToString:@"Events"]) {
        controller = [[FeedTableController alloc] init];
    } else if ([title isEqualToString:@"Agenda"]) {
        controller = [[AgendaTableController alloc] init];
    } else if ([title isEqualToString:@"Settings"]) {
        controller = [[SettingsController alloc] init];
    } else if ([title isEqualToString:@"Info"]) {
        controller = [[InfoViewController alloc] init];
    }
    
    if (controller != nil) {
        controller.title = title;
        [self.navigationController pushViewController:controller animated:true];
        [controller release];
    }
}


 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [super dealloc];
}

@end
