//
//  DSJournalSerializer.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSJournalSerializer.h"

#import "DSActivitySerializer.h"

@implementation DSJournalSerializer

- (DSJournal *) deserializeJournalFrom:(NSDictionary *)representation andInsertAt:(DSJournalInsertAt) insertAt
{
    DSJournal *journal = [self.dataAdapter findOrCreate:@"Journal" onModel:@"Journal" error:nil];
    
    DSActivitySerializer *activitySerializer = [[DSActivitySerializer alloc] init];
    
    if(insertAt == DSJournalInsertAtBeginning) {
        for (NSDictionary *activityRepresentation in [representation[@"activity"] reverseObjectEnumerator])
        {
            DSActivity *activity = [activitySerializer deserializeActivityFrom:activityRepresentation];
            [journal insertObject:activity inActivitiesAtIndex:0];
            //[journal addActivitiesObject:activity];
        }
    }
    else if(insertAt == DSJournalInsertAtEnd) {
        for (NSDictionary *activityRepresentation in representation[@"activity"])
        {
            DSActivity *activity = [activitySerializer deserializeActivityFrom:activityRepresentation];
            [journal addActivitiesObject:activity];
        }
    }
    else {
        NSLog(@"Error: DSJournalInsertAt provided is not valid: %u", insertAt);
    }
    
	[self.dataAdapter save:nil];
    return journal;
}

@end
