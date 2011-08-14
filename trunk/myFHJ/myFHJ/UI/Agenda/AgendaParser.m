//
//  AgendaParser.m
//  myFHJ
//
//  Created by Markus Scheucher on 12.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AgendaParser.h"
#import "Event.h"

@implementation AgendaParser

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here. 
    }
    
    return self;
}

- (NSArray*) fetchCalFromURL:(NSString*)URLString
{    
    NSError *error = nil;
    NSString *calContent = [NSString stringWithContentsOfURL:[NSURL URLWithString:URLString] 
                                                    encoding:NSUTF8StringEncoding 
                                                       error:&error];
//    Test
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"stundenplan" ofType:@"ics"];
//    NSString *calContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error != nil) {
        NSLog(@"error: %@", [error description]);
    } else
    { 
        NSScanner *veventScanner = [NSScanner scannerWithString:calContent];
        NSString *text;
        NSMutableArray *events = [[NSMutableArray alloc] initWithCapacity:1];
        
        while ([veventScanner isAtEnd] == NO) {
            
            // find start of tag
            [veventScanner scanUpToString:@"BEGIN:VEVENT" intoString:NULL] ; 
            
            text = nil;
            
            // find end of tag
            [veventScanner scanUpToString:@"END:VEVENT" intoString:&text] ;
            
            if (text != nil) {
                [events addObject:text];
            }
            
            
            // replace the found tag with a space
            //(you can filter multi-spaces out later if you wish)
            calContent = [calContent stringByReplacingOccurrencesOfString:
                    [ NSString stringWithFormat:@"%@", text]
                                                   withString:@" "];
            
        } // while //
        
        NSMutableArray *eventEntities = [[NSMutableArray alloc]initWithCapacity:[events count]];
        for (NSString *e in events) {
            //NSLog(@"event: %@", e);
            Event *eventE = [[Event alloc] initWithVEVENT:e];
            [eventEntities addObject:eventE];
            [eventE release];
        }
        
        [events release];
        
//        for (Event *ee in eventEntities) {
//            NSLog(@"ee: %@", [ee start]);
//            NSLog(@"ee: %@", [ee end]);
//            NSLog(@"ee: %@", [ee summary]);
//            NSLog(@"ee: %@", [ee location]);
//        }
        
        return [eventEntities autorelease];
    }
    
    return nil;
}

@end
