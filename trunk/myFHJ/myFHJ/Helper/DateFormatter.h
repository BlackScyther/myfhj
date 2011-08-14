//
//  DateFormatter.h
//  myFHJ
//
//  Created by Markus Scheucher on 14.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject
{
    NSCalendar *_gregorian;
}

- (NSString*) nextDayFromDate:(NSDate*)day;
- (NSString*) dateStringFromDate:(NSDate*)date;
- (NSString*) timeStringFromDate:(NSDate*)date;
- (NSDate*) dateFromDateString:(NSString*)dateString;

@end
