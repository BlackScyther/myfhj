//
//  DateFormatter.m
//  myFHJ
//
//  Created by Markus Scheucher on 14.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

- (id)init
{
    self = [super init];
    if (self) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    return self;
}

- (void)dealloc {
    [_gregorian release];
    [super dealloc];
}

- (NSString*) nextDayFromDate:(NSDate*)day
{
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    NSDate *nextDate = [_gregorian dateByAddingComponents:offsetComponents toDate:day options:0];
    [offsetComponents release];

    NSString *dateString = [self dateStringFromDate:nextDate];

    return dateString;
}

- (NSString*) dateStringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [dateFormatter release];
  
    return dateString;
}

- (NSString*) timeStringFromDate:(NSDate*)date
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *timeString = [timeFormatter stringFromDate:date];
    [timeFormatter release];
 
    return timeString;
}

- (NSDate*) dateFromDateString:(NSString*)dateString
{
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
    NSDate *date = [inputDateFormatter dateFromString:dateString];
    [inputDateFormatter release];
    
    return date;
}

@end
