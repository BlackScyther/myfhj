//
//  NewsFeedController.h
//  myFHJ
//
//  Created by Markus Scheucher on 21.10.10.
//  Copyright 2010 Datentechnik Innovation GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchXML.h"


@interface FeedTableController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	// This is the outlet for the blog view, it will allow the data from the controller to be used in a view
    IBOutlet UITableView *blogTable;
	
    // blogEntries is used to store the data retrieved from the RSS feed before being added to the view
    NSMutableArray *newsEntries;
	
    // loadSwirlie will display a loading overlay while the data is downloaded from the RSS feed.
    UIActivityIndicatorView *loadSwirlie;
	
}

-(void) grabRSSFeed:(NSString *)blogAddress;

@end
