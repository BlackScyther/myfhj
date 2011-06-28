//
//  FeedController.m
//  myFHJ
//
//  Created by Markus Scheucher on 04.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedController.h"


@implementation FeedController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_tableController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UIAction

- (IBAction) showNewsFeed:(id)sender 
{
    [_tableController release];
    _tableController = [[FeedTableController alloc] initWithNibName:nil bundle:nil];
    _tableController.title = @"News";
}

- (IBAction) showEventsFeed:(id)sender 
{
    [_tableController release];
    _tableController = [[FeedTableController alloc] initWithNibName:nil bundle:nil];
    _tableController.title = @"Events";
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableController = [[FeedTableController alloc] initWithNibName:nil bundle:nil];
    _tableController.title = @"News";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
