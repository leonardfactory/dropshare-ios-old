//
//  DropCollection.m
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DropCollection.h"
#import "Drop.h"


@implementation DropCollection

@dynamic identifier;
@dynamic drops;

- (void)addDropsObject:(Drop *)value
{
	NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.drops];
	[tempSet addObject:value];
	self.drops = tempSet;
}

- (void)removeDropsObject:(Drop *)value
{
	NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.drops];
	[tempSet removeObject:value];
	self.drops = tempSet;
}

@end
