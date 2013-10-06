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

- (DSUser *) deserializeUserFrom:(NSDictionary *) dict
{
	assert(dict);
	NSString *identifier = dict[@"_id"];
	DSUser *user = [self.dataAdapter findOrCreate:identifier onModel:@"User" error:nil];
    
    NSString *completeName = dict[@"complete_name"];
    if(completeName) {
        [user setCompleteName:dict[@"complete_name"]];
    }
    
	[user setUsername:[dict objectForKey:@"username"]];
	
    NSString *createdOn = [dict objectForKey:@"createdOn"];
    if(createdOn) {
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        [user setCreatedOn:[formatter dateFromString:dict[@"createdOn"]]];
    }
   
	[self.dataAdapter save:nil];
	return user;
}

@end
