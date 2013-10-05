//
//  DSUserSerializer.m
//  Movover
//
//  Created by @leonardfactory on 13/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSUserSerializer.h"

#import "DSUser.h"

#import <ISO8601DateFormatter.h>

@implementation DSUserSerializer

@synthesize dataAdapter = _dataAdapter;

- (DSUserSerializer *) init
{
	_dataAdapter = [[DSDataAdapter alloc] init];
	return self;
}

- (DSUser *) deserializeUserFrom:(NSDictionary *) dict
{
	assert(dict);
	NSString *identifier = dict[@"_id"];
	DSUser *user = [_dataAdapter findOrCreate:identifier onModel:@"User" error:nil];
    
	[user setCompleteName:dict[@"complete_name"]];
	[user setUsername:[dict objectForKey:@"username"]];
	
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
	[user setCreatedOn:[formatter dateFromString:dict[@"createdOn"]]];
	
	[_dataAdapter save:nil];
	return user;
}

@end
