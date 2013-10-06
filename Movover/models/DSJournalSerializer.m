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

- (DSJournal *) deserializeJournalFrom:(NSDictionary *) representation
{
    DSJournal *journal = [self.dataAdapter findOrCreate:@"Journal" onModel:@"Journal" error:nil];
    
    DSActivitySerializer *activitySerializer = [[DSActivitySerializer alloc] init];
	for (NSDictionary *activityRepresentation in representation[@"activity"])
    {
		DSActivity *activity = [activitySerializer deserializeActivityFrom:activityRepresentation];
        [journal addActivitiesObject:activity];
	}
    
	[self.dataAdapter save:nil];
    return journal;
}

@end
