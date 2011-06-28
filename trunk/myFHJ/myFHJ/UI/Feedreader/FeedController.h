//
//  FeedController.h
//  myFHJ
//
//  Created by Markus Scheucher on 04.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedTableController.h"


@interface FeedController : UIViewController {
    
    FeedTableController *_tableController;
}

- (IBAction) showNewsFeed:(id)sender;
- (IBAction) showEventsFeed:(id)sender;

@end
