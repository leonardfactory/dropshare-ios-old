//
//  DSActionSerializer.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSActionSerializer.h"

#import <ISO8601DateFormatter.h>

@implementation DSActionSerializer

- (DSAction *) deserializeActionFrom:(NSDictionary *) representation
{
    // _id & fetching
    NSString *identifier = representation[@"_id"];
    
    DSAction *action = [self.dataAdapter findOrCreate:identifier onModel:@"Action" error:nil];
    
    // Area
    // @todo implement serializer
    
    // createdOn
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
    [action setCreatedOn:[formatter dateFromString:representation[@"createdOn"]]];
    
    // Subject handling (user or area)
    // @todo
    
    [self.dataAdapter save:nil];
    return action;
}

@end
