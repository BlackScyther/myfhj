//
//  InfoViewController.m
//  myFHJ
//
//  Created by Markus Scheucher on 22.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_textView setBackgroundColor:[UIColor clearColor]];
    
    NSString *infoPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"txt"];
    NSError *error = nil;
    
    NSString *info = [NSString stringWithContentsOfFile:infoPath encoding:NSUTF8StringEncoding error:&error]; 
    
    if (error != nil) {
        NSLog(@"Error, could not read Infor: %@", [error description]);
    } else {
        _textView.text = info;
    }
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
