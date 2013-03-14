//
//  DSDropSerializer.m
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSDropSerializer.h"

@implementation DSDropSerializer

- (DSDropSerializer *) init
{
	_dataAdapter = [[DSDataAdapter alloc] init];
	return self;
}

- (void) deserializeDropSetFrom:(NSArray *) array intoDropCollection:(DropCollection *) collection
{
	[collection setDrops:[[NSOrderedSet alloc]init]];
	[_dataAdapter save:nil];
	[self deserializeDropSetFrom:array appendIntoDropCollection:collection];
}

- (int) deserializeDropSetFrom:(NSArray *) array appendIntoDropCollection:(DropCollection *) collection
{
	int count = 0;
	for (NSDictionary *dict in array) {
		count++;
		Drop *drop = [self deserializeDropFrom:dict];
		[collection addDropsObject:drop];
	}
	[_dataAdapter save:nil];
	return count;
}

- (Drop *) deserializeDropFrom:(NSDictionary *) dict
{
	assert(dict);
	NSString *identifier = [dict objectForKey:@"_id"];
	
	Drop *drop = [_dataAdapter findOrCreate:identifier onModel:@"Drop" error:nil];
	
	[drop setType:[dict objectForKey:@"type"]];
	if ([dict objectForKey:@"text"])
	{
		[drop setText:[dict objectForKey:@"text"]];
	}
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	[drop setCreatedOnString:[dict objectForKey:@"createdOn"]];
	NSDate *myDate = [dateFormatter dateFromString:[dict objectForKey:@"createdOn"]];
	[drop setCreatedOn:myDate];
	
	DSUserSerializer *us = [[DSUserSerializer alloc] init];
	User *user = [us deserializeUserFrom:[dict objectForKey:@"user"]];
	[drop setUser:user];
	
	NSDictionary *loc = [dict objectForKey:@"loc"];
	NSDictionary *stat = [dict objectForKey:@"stat"];
	
	[drop setLatitude:[loc objectForKey:@"lat"]];
	[drop setLongitude:[loc objectForKey:@"lng"]];
	
	[drop setTotComments:[stat objectForKey:@"comment"]];
	[drop setTotLikes:[stat objectForKey:@"like"]];
	[drop setTotRedrops:[stat objectForKey:@"redrop"]];
	
	[_dataAdapter save:nil];
	return drop;
}


@end
