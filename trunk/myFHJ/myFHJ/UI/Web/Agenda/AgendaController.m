//
//  AgendaController.m
//  myFHJ
//
//  Created by Markus Scheucher on 25.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AgendaController.h"


@implementation AgendaController

- (id) init
{
	self = [super initWithNibName:@"AgendaView" bundle:nil];
	if (self != nil) {
        
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

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Create a URL object.
	NSURL *url;
    
    if ([self.title isEqualToString:@"Agenda"]) {
        url = [NSURL URLWithString:[self agendaURLString]];
    }
	
	//URL Requst Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[_webView loadRequest:requestObj];
}

- (NSString*) agendaURLString
{
    NSString *pCode = [[[NSUserDefaults standardUserDefaults] stringForKey:@"userProgrammeCode"] lowercaseString];
    NSString *year = [[NSUserDefaults standardUserDefaults] stringForKey:@"userYear"];
    NSString *urlAddress;
    
    if (pCode != nil && year != nil) {
        urlAddress = [NSString stringWithFormat:@"http://stundenplan.fh-joanneum.at/?login=login&user=%@&pass=%@&new_jg=%@", pCode, pCode, year];    
    
    } else {
        urlAddress = [[NSUserDefaults standardUserDefaults] stringForKey:@"defaultAgendaURL"];
    }
    
    return urlAddress;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
