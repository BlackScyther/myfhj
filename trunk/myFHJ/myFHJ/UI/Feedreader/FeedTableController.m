//
//  NewsFeedController.m
//  myFHJ
//
//  Created by Markus Scheucher on 21.10.10.
//  Copyright 2010 Datentechnik Innovation GmbH. All rights reserved.
//

#import "FeedTableController.h"
#import "AppDelegate.h"


@implementation FeedTableController


#pragma mark -
#pragma mark View lifecycle

- (id) init
{
	self = [super initWithNibName:@"FeedView" bundle:nil];
	if (self != nil) {
		newsEntries = nil;
	}
	return self;
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	
	if([newsEntries count] == 0) {
        // Create the feed string, in this case I have used dBlog
		NSString *blogAddress = @"";
		
		if ([[self title] isEqualToString:@"News"]) {
			NSString *newsURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"defaultNewsURL"];
			blogAddress = newsURL;
		} else if ([[self title] isEqualToString:@"Events"]) {
			NSString *eventsURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"defaultEventsURL"];
			blogAddress = eventsURL; ;
		}
		
        // Call the grabRSSFeed function with the above
        // string as a parameter
        [self grabRSSFeed:blogAddress];
    }
}

/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// grabRSSFeed function that takes a string (blogAddress) as a parameter and
// fills the global blogEntries with the entries
-(void) grabRSSFeed:(NSString *)blogAddress {
	
    // Initialize the blogEntries MutableArray that we declared in the header
	if (newsEntries != nil) {
		[newsEntries release];
		newsEntries = nil;
	}
	
    newsEntries = [[NSMutableArray alloc] init];	
	
    // Convert the supplied URL string into a usable URL object
    NSURL *url = [NSURL URLWithString: blogAddress];
	
    // Create a new rssParser object based on the TouchXML "CXMLDocument" class, this is the
    // object that actually grabs and processes the RSS data
    CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithContentsOfURL:url 
																  encoding:NSISOLatin1StringEncoding 
																   options:0 
																	 error:nil] autorelease];
	
    // Create a new Array object to be used with the looping of the results from the rssParser
    NSArray *resultNodes = NULL;
	
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
		
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
		
        // Create a counter variable as type "int"
        int counter;
		
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
			
            // Add each field to the blogItem Dictionary with the node name as key and node value as the value
            [blogItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        }
		
        // Add the blogItem to the global blogEntries Array so that the view can access it.
//        [newsEntries addObject:[blogItem copy]];
        [newsEntries addObject:blogItem];
		
		[blogItem release];
        
        // Call the reloadData function on the blogTable, this
        // will cause it to refresh itself with our new data
    }
    [blogTable reloadData];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [newsEntries count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.detailTextLabel.numberOfLines = 0;
    }
    
    // Configure the cell...
	int blogEntryIndex = [indexPath indexAtPosition: [indexPath length] -1];
	
	cell.textLabel.text= [[newsEntries objectAtIndex: blogEntryIndex] objectForKey: @"title"];
	cell.detailTextLabel.text = [[newsEntries objectAtIndex: blogEntryIndex] objectForKey: @"description"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
	
    CGFloat width = tableView.frame.size.width - 10*2;
    
    if (cell.textLabel.font == nil | cell.textLabel.font.pointSize == 0 ) {
        [cell layoutSubviews];
        
        // HL no good design, but works for now and should be sufficient for one month until iOS4 is available for the iPad
		
//        IF_PRE_IOS4(cell.textLabel.font = [UIFont systemFontOfSize:18];)        
//        IF_PRE_IOS4(cell.detailTextLabel.font = [UIFont systemFontOfSize:14];)
		
    }
    
    CGSize detailTextSize = [cell.detailTextLabel.text sizeWithFont:cell.detailTextLabel.font
                                                  constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                                                      lineBreakMode:UILineBreakModeTailTruncation];
	
    CGSize textSize = [cell.textLabel.text sizeWithFont:cell.textLabel.font
                                      constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                                          lineBreakMode:UILineBreakModeWordWrap];
	
    return 10*2 + detailTextSize.height + textSize.height;
	
}

//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
//{
//    return self.title;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[newsEntries release];
    [super dealloc];
}


@end

