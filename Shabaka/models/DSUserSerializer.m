//
//  DSUserSerializer.m
//  Shabaka
//
//  Created by Francesco on 13/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSUserSerializer.h"

@implementation DSUserSerializer

@synthesize dataAdapter = _dataAdapter;

- (DSUserSerializer *) init
{
	_dataAdapter = [[DSDataAdapter alloc] init];
	return self;
}

- (User *) deserializeUserFrom:(NSDictionary *) dict
{
	assert(dict);
	NSString *identifier = [dict objectForKey:@"_id"];
	User *user = [_dataAdapter findOrCreate:identifier onModel:@"User" error:nil];
	[user setName:[dict objectForKey:@"name"]];
	[user setSurname:[dict objectForKey:@"surname"]];
	[user setUsername:[dict objectForKey:@"username"]];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	[user setStringCreatedOn:[dict objectForKey:@"createdOn"]];
	
	NSDate *myDate = [dateFormatter dateFromString:[dict objectForKey:@"createdOn"]];
	
	[user setCreatedOn:myDate];
	
	[_dataAdapter save:nil];
	return user;
}

@end
