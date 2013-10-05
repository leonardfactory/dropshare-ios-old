//
//  DSActivitySerializer.m
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSActivitySerializer.h"

#import "DSUserSerializer.h"

#import <ISO8601DateFormatter.h>

@implementation DSActivitySerializer

- (DSActivity *) deserializeActivityFrom:(NSDictionary *) representation
{
    NSString *identifier = representation[@"_id"];
    
    DSActivity *activity = [_dataAdapter findOrCreate:identifier onModel:@"Activity" error:nil];
    
    [activity setData:representation[@"data"]];
    
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
    [activity setCreatedOn:[formatter dateFromString:representation[@"createdOn"]]];
    
    DSUserSerializer *userSerializer = [[DSUserSerializer alloc] init];
    
}

@end
