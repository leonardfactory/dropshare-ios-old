//
//  DSActivitySerializer.m
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSActivitySerializer.h"

#import "DSUserSerializer.h"
#import "DSActionSerializer.h"
#import "DSAreaSerializer.h"

#import <ISO8601DateFormatter.h>

@implementation DSActivitySerializer

- (DSActivity *) deserializeActivityFrom:(NSDictionary *) representation
{
    assert(representation);
    NSLog(@"Representation: %@", representation);
    
    // _id & fetching
    NSString *identifier = representation[@"_id"];
    
    DSActivity *activity = [self.dataAdapter findOrCreate:identifier onModel:@"Activity" error:nil];
    
    // Mixed data
    [activity setData:representation[@"data"]];
    
    // Area
    DSAreaSerializer *areaSerializer = [[DSAreaSerializer alloc] init];
    [activity setArea:[areaSerializer deserializeAreaFrom:representation[@"area"]]];
    
    // ObjectID
    if([representation[@"verb"] isEqualToString:@"publish_action"]) {
        [activity setObjectEntity:@"Action"];
        
        DSActionSerializer *actionSerializer = [[DSActionSerializer alloc] init];
        DSAction *action = [actionSerializer deserializeActionFrom:representation[@"object"]];
        
        [activity setObjectId:action.identifier];
    }
    else {
        [activity setObjectId:representation[@"object"]];
    }
    
    [activity setVerb:representation[@"verb"]];
    
    // createdOn
    ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
    [activity setCreatedOn:[formatter dateFromString:representation[@"createdOn"]]];
    
    // Subject handling (user or area)
    NSDictionary *subject = representation[@"subject"];
    
    if([subject[@"ref"] isEqualToString:@"User"]) {
        DSUserSerializer *userSerializer = [[DSUserSerializer alloc] init];
        
        NSMutableDictionary *userData = [[subject valueForKey:@"data"] mutableCopy];
        [userData setValue:subject[@"_id"] forKey:@"_id"];
        
        DSUser *user = [userSerializer deserializeUserFrom:userData];
        [activity setSubjectId:user.identifier];
    }
    else if([subject[@"ref"] isEqualToString:@"Area"]) {
        // implement DSAreaSerializer
    }
    
    [self.dataAdapter save:nil];
    return activity;
}

@end
