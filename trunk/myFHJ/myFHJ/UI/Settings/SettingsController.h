//
//  SettingsController.h
//  myFHJ
//
//  Created by Markus Scheucher on 03.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate> {
    
    IBOutlet UIScrollView *scrollView;
	IBOutlet UINavigationItem *navitem;
	
	IBOutlet UIBarButtonItem *btnSubmit;
	IBOutlet UIBarButtonItem *btnBack;
    
	IBOutlet UITextField *txtLastName;
	IBOutlet UITextField *txtFirstName;
	
    IBOutlet UILabel *lblData;
	IBOutlet UILabel *lblLastName;
	IBOutlet UILabel *lblFirstName;
	IBOutlet UILabel *lblProgramme;
    
    IBOutlet UIButton *btnLocation;
    IBOutlet UIButton *btnYear;
    IBOutlet UIButton *btnCode;
	
	float animatedDistance;
	
	UIViewController *_controller;
}


- (void) moveUp:(UIView*)controll; 
- (void) moveDown:(UIView*)controll; 
- (IBAction) back:(id)sender;
- (IBAction) save:(id)sender;
- (void)saveText:(UITextField*)textField;

- (IBAction) setLocation:(id)sender; 
- (IBAction) setProgrammeCode:(id)sender; 
- (IBAction) setYear:(id)sender; 
- (void) showActionSheetWithTitle:(NSString*)title buttons:(NSArray*)content sheet:(NSUInteger)tag;

@end
