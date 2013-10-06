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
    // _id & fetching
    NSString *identifier = representation[@"_id"];
    
    DSActivity *activity = [_dataAdapter findOrCreate:identifier onModel:@"Activity" error:nil];
    
    // Mixed data
    [activity setData:representation[@"data"]];
    
    // createdOn
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
    [activity setCreatedOn:[formatter dateFromString:representation[@"createdOn"]]];
    
    // Subject handling (user or area)
    NSDictionary *subject = representation[@"subject"];
    
    if([subject[@"ref"] isEqualToString:@"user"]) {
        DSUserSerializer *userSerializer = [[DSUserSerializer alloc] init];
        
        NSMutableDictionary *userData = [[subject valueForKey:@"data"] mutableCopy];
        [userData setValue:subject[@"_id"] forKey:@"_id"];
        
        DSUser *user = [userSerializer deserializeUserFrom:userData];
        [activity setSubjectId:user.identifier];
    }
    else if([subject[@"ref"] isEqualToString:@"area"]) {
        // implement DSAreaSerializer
    }
    
    [_dataAdapter save:nil];
    return activity;
}

@end
