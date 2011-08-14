//
//  Event.h
//  myFHJ
//
//  Created by Markus Scheucher on 13.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    NSString *_start;
    NSString *_end;
    NSString *_location;
    NSString *_summary;
}

- (id)initWithVEVENT:(NSString*)VEVENT;

@property(nonatomic, copy) NSString *start;
@property(nonatomic, copy) NSString *end;
@property(nonatomic, copy) NSString *location;
@property(nonatomic, copy) NSString *summary;

@end
