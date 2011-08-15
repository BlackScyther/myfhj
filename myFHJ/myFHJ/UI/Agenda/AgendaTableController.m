//
//  AgendaTableController.m
//  myFHJ
//
//  Created by Markus Scheucher on 12.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AgendaTableController.h"
#import "AgendaParser.h"
#import "Event.h"
#import "DateFormatter.h"

#define ALMATY_URL_BASE @"http://almaty.fh-joanneum.at/stundenplan/search.php"

@implementation AgendaTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    AgendaParser *parser = [[AgendaParser alloc] init];    
    
    NSString *code = [[NSUserDefaults standardUserDefaults] stringForKey:@"userProgrammeCode"];
    NSString *year = [[NSUserDefaults standardUserDefaults] stringForKey:@"userYear"];
    
    NSString *calURL = [NSString stringWithFormat:@"%@?q=%%22%@+%@", ALMATY_URL_BASE, code, year];
    NSString *calURLToday = [NSString stringWithFormat:@"%@%%22+heute", calURL];
    NSString *calURLTomorow = [NSString stringWithFormat:@"%@%%22+morgen", calURL];
    
    _coursesToday = [[NSArray alloc] initWithArray:[parser fetchCalFromURL:calURLToday]];
    _coursesTomorow = [[NSArray alloc] initWithArray:[parser fetchCalFromURL:calURLTomorow]];
    
    [parser release];
}

- (void)dealloc {
    [_coursesToday release];
    [_coursesTomorow release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2; // today and tomorrow
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Event *event = nil;
    NSString *header = @"";
    NSString *dateString = @"";
    DateFormatter *formatter = [[DateFormatter alloc] init];
    
    if (section == 0) {
        if ([_coursesToday count] > 0) {
            event = [_coursesToday objectAtIndex:0];
            NSDate *date = [formatter dateFromDateString:[event start]];
            dateString = [formatter dateStringFromDate:date];
        } else {
            dateString = [formatter dateStringFromDate:[NSDate date]];
        }
        
        header = [NSString stringWithFormat:@"%@ - %@", NSLocalizedString(@"agenda.today", @""), dateString];
    } else 
    {
        if ([_coursesTomorow count] > 0) {
            event = [_coursesTomorow objectAtIndex:0];
            NSDate *date = [formatter dateFromDateString:[event start]];
            dateString = [formatter dateStringFromDate:date];
        } else {
            
            dateString = [formatter nextDayFromDate:[NSDate date]];
            
        }
        
        header = [NSString stringWithFormat:@"%@ - %@", NSLocalizedString(@"agenda.tomorow", @""), dateString];
    }
    
    [formatter release];              
                  
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if ([_coursesToday count] > 0) {
            return [_coursesToday count];
        } else
        {
            return 1;
        }
    } else 
    {
        if ([_coursesTomorow count] > 0) {
            return [_coursesTomorow count];
        } else
        {
            return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
	
    CGFloat width = tableView.frame.size.width - 10*2;
    
    if (cell.textLabel.font == nil | cell.textLabel.font.pointSize == 0 ) 
    {
        [cell layoutSubviews];
    }
    
    CGSize detailTextSize = [cell.detailTextLabel.text sizeWithFont:cell.detailTextLabel.font
                                                  constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                                                      lineBreakMode:UILineBreakModeTailTruncation];
	
    CGSize textSize = [cell.textLabel.text sizeWithFont:cell.textLabel.font
                                      constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                                          lineBreakMode:UILineBreakModeWordWrap];
	
    return 20*2 + detailTextSize.height + textSize.height;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    int section = indexPath.section;
    int row = indexPath.row;
    NSArray *tmp = nil;
    DateFormatter *formatter = [[DateFormatter alloc] init];
    
    if (section == 0) {
        tmp = [[NSArray alloc] initWithArray:_coursesToday];
    } else 
    {
        tmp = [[NSArray alloc] initWithArray:_coursesTomorow];
    }
    
    if ([tmp count] > 0) 
    {
        Event *event = [tmp objectAtIndex:row];
        NSDate *startDate = [formatter dateFromDateString:[event start]];
        NSDate *endDate = [formatter dateFromDateString:[event end]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", 
                               [formatter timeStringFromDate:startDate], 
                               [formatter timeStringFromDate:endDate]];  
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", 
                                     [event summary], 
                                     [event location]];
    } else
    {
        cell.textLabel.text = NSLocalizedString(@"agenda.noCourses", @" ");
    }
    
    [tmp release];
    [formatter release];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
