//
//  DSJournal.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSJournal.h"
#import "DSActivity.h"


@implementation DSJournal

@dynamic identifier;
@dynamic updatedOn;
@dynamic activities;

- (void)insertObject:(DSActivity *)value inActivitiesAtIndex:(NSUInteger)idx
{
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"activities"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self mutableOrderedSetValueForKey:@"activities"]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"activities"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"activities"];
}

- (void)addActivitiesObject:(DSActivity *)value
{
	NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.activities];
	[tempSet addObject:value];
	self.activities = tempSet;
}

@end
