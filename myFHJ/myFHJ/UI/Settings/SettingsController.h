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
    
//	IBOutlet UITextField *txtLastName;
//	IBOutlet UITextField *txtFirstName;
//	
//    IBOutlet UILabel *lblData;
//	IBOutlet UILabel *lblLastName;
//	IBOutlet UILabel *lblFirstName;
	IBOutlet UILabel *lblProgramme;
    
    IBOutlet UIButton *btnLocation;
    IBOutlet UIButton *btnYear;
    IBOutlet UIButton *btnCode;
	
	float animatedDistance;
	
	UIViewController *_controller;
}


//- (void) moveUp:(UIView*)controll; 
//- (void) moveDown:(UIView*)controll; 
//- (void)saveText:(UITextField*)textField;

- (IBAction) showLocationInfo:(id)sender;
- (IBAction) showCodeInfo:(id)sender;
- (IBAction) showYearInfo:(id)sender;
- (void) showInfo:(NSString*)message; 

- (IBAction) setLocation:(id)sender; 
- (IBAction) setProgrammeCode:(id)sender; 
- (IBAction) setYear:(id)sender; 
- (void) showActionSheetWithTitle:(NSString*)title buttons:(NSArray*)content sheet:(NSUInteger)tag;

@end
