//
//  SettingsController.m
//  myFHJ
//
//  Created by Markus Scheucher on 03.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsController.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;

@implementation SettingsController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id) init
{
	self = [super initWithNibName:@"SettingsView" bundle:nil];
	if (self != nil) {
        
	}
	return self; 
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	
	[scrollView setContentSize:CGSizeMake(320.0f,750.0f)];
    
    lblData.text = @"Persönliche Daten";
    lblFirstName.text = @"Vorname";
    lblLastName.text = @"Nachname";
    lblProgramme.text = @"Strudiengang";
    
    NSString *firstname = [[NSUserDefaults standardUserDefaults] stringForKey:@"userFirstname"];
    if (firstname == nil) {
        firstname = @"";
    }
    txtFirstName.text = firstname;
    txtFirstName.tag = 1;
    
    NSString *lastname = [[NSUserDefaults standardUserDefaults] stringForKey:@"userLastname"];
    if (lastname == nil) {
        lastname = @"";
    }
    txtLastName.text = lastname;
    txtLastName.tag = 2;
    
    NSString *location = [[NSUserDefaults standardUserDefaults] stringForKey:@"userLocation"];
    if (location == nil) {
        location = @"Standort";
    }
    [btnLocation setTitle:location forState:UIControlStateNormal];
    
    NSString *pCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"userProgrammeCode"];
    if (pCode == nil) {
        pCode = @"Kürzel";
    }
    [btnCode setTitle:pCode forState:UIControlStateNormal];
    
    NSString *year = [[NSUserDefaults standardUserDefaults] stringForKey:@"userYear"];
    if (year == nil) {
        year = @"Jahrgang";
    }
    [btnYear setTitle:year forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark Action

- (void) moveUp:(UIView*)controll {
	
	CGRect textFieldRect = [scrollView.window convertRect:controll.bounds fromView:controll];
    CGRect viewRect = [scrollView.window convertRect:scrollView.bounds fromView:scrollView];
	
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0) {
        heightFraction = 0.0;
    } else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }
	
	UIInterfaceOrientation orientation =
	[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    } else {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
	
    CGRect viewFrame = scrollView.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [scrollView setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void) moveDown:(UIView*)controll {
	CGRect viewFrame = scrollView.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [scrollView setFrame:viewFrame];
	
    //self.navigationItem.rightBarButtonItem.enabled = [self shouldEnableSave];
    
    [UIView commitAnimations];
}

- (IBAction) save:(id)sender {

}

- (IBAction) back:(id)sender {
	[self.navigationController popViewControllerAnimated:true];
}

- (IBAction) setLocation:(id)sender 
{
    NSArray *locations = [NSArray arrayWithObjects:@"Graz", @"Kapfenberg", @"Bad Gleichenberg", nil];
 
    [self showActionSheetWithTitle:@"Standort" buttons:locations sheet:1];
}

- (IBAction) setProgrammeCode:(id)sender 
{
    NSArray *codes = [NSArray arrayWithObjects:@"ITM", @"SWD", nil];
    
    [self showActionSheetWithTitle:@"Kürzel" buttons:codes sheet:2];
}

- (IBAction) setYear:(id)sender 
{
    NSArray *years = [NSArray arrayWithObjects:@"2008", @"2007", @"2006", @"2005", @"2004", nil];
    
    [self showActionSheetWithTitle:@"Jahrgang" buttons:years sheet:3];
}

- (void) showActionSheetWithTitle:(NSString*)title buttons:(NSArray*)content sheet:(NSUInteger)tag
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title 
                                                             delegate:self 
                                                    cancelButtonTitle:@"Abbrechen" 
                                               destructiveButtonTitle:nil 
                                                    otherButtonTitles:nil];
    for (NSString *button in content) {
        [actionSheet addButtonWithTitle:button];
    }
    [actionSheet setTag:tag];
    [actionSheet showInView:self.view];
    [actionSheet release];
}
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (![buttonTitle isEqualToString:@"Abbrechen"]) 
    {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];

        if (actionSheet.tag == 1)
        {
            [btnLocation setTitle:buttonTitle forState:UIControlStateNormal];
            [defaults setObject:buttonTitle forKey:@"userLocation"];
            
        } else if (actionSheet.tag == 2)
        {
            [btnCode setTitle:buttonTitle forState:UIControlStateNormal];
            [defaults setObject:buttonTitle forKey:@"userProgrammeCode"];
            
        } else if (actionSheet.tag == 3)
        {
            [btnYear setTitle:buttonTitle forState:UIControlStateNormal];
            [defaults setObject:buttonTitle forKey:@"userYear"];
            
        }
    }
}

#pragma mark UIScrollViewDelegate

//method to move the view up/down whenever the keyboard is shown/dismissed
#pragma mark UITextFieldDelegate methods

//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//	
//	[self moveUp:textField];    
//}
//
- (void)textFieldDidEndEditing:(UITextField *)textField {
	
    [self saveText:textField];

	//[self moveDown:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //	AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    [self saveText:textField];
    
	[textField resignFirstResponder];
	return true;
}

- (void)saveText:(UITextField*)textField 
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    NSString *text = textField.text;
    
    if (textField.tag == 1) {
        [defaults setObject:text forKey:@"userFirstname"];
    } 
    else if (textField.tag == 2) {
        [defaults setObject:text forKey:@"userLastname"];
    }
}

#pragma mark mm

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
