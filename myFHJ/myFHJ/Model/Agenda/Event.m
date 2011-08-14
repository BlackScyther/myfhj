//
//  Event.m
//  myFHJ
//
//  Created by Markus Scheucher on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@interface Event(private)

- (void) parseVEVENT:(NSString*)VEVENT;

@end

@implementation Event

@synthesize start = _start;
@synthesize end = _end;
@synthesize summary = _summary;
@synthesize location = _location;

- (id)initWithVEVENT:(NSString*)VEVENT
{
    self = [super init];
    if (self) {
        // Initialization code here.
        [self parseVEVENT:VEVENT];
    }
    
    return self;
}

-(void)dealloc
{
    [_start release];
    [_end release];
    [_summary release];
    [_location release];
    
    [super dealloc];
}

- (void) parseVEVENT:(NSString*)VEVENT
{
    NSArray *elements = [VEVENT componentsSeparatedByString:@"\n"];
    
    if ([elements count] > 0) {
        
        for (NSString *e in elements) {
            
            if ([e hasPrefix:@"DTSTART"]) {
                e = [e stringByReplacingOccurrencesOfString:@"DTSTART;TZID=Europe/Vienna:" withString:@""];
                _start = [e copy];
            }
            
            if ([e hasPrefix:@"DTEND"]) {
                e = [e stringByReplacingOccurrencesOfString:@"DTEND;TZID=Europe/Vienna:" withString:@""];
                _end = [e copy];
            }
            
            if ([e hasPrefix:@"LOCATION"]) {
                e = [e stringByReplacingOccurrencesOfString:@"LOCATION:" withString:@""];
                _location = [e copy];
            }
            
            if ([e hasPrefix:@"SUMMARY"]) {
                e = [e stringByReplacingOccurrencesOfString:@"SUMMARY:" withString:@""];
                _summary = [e copy];
            }
        }
        
    }
}

@end
