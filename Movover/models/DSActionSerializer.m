//
//  DSActionSerializer.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSActionSerializer.h"
#import "DSAreaSerializer.h"

#import <ISO8601DateFormatter.h>

@implementation DSActionSerializer

- (DSAction *) deserializeActionFrom:(NSDictionary *) representation
{
    // _id & fetching
    NSString *identifier = representation[@"_id"];
    
    DSAction *action = [self.dataAdapter findOrCreate:identifier onModel:@"Action" error:nil];
    
    // Like
    if(representation[@"like"]) {
        [action setLike:representation[@"like"]];
    }
    
    // Position
    if(representation[@"position"]) {
        [action setLatitude:representation[@"position"][@"lat"]];
        [action setLongitude:representation[@"position"][@"lon"]];
    }
    
    // Stats
    if(representation[@"stats"]) {
        [action setStatsLike:representation[@"stats"][@"like"]];
        [action setStatsComment:representation[@"stats"][@"comment"]];
        [action setStatsReaction:representation[@"stats"][@"reaction"]];
    }
    
    // Area
    if(representation[@"area"]) {
        DSAreaSerializer *areaSerializer = [[DSAreaSerializer alloc] init];
        [action setArea:[areaSerializer deserializeAreaFrom:representation[@"area"]]];
    }
    
    // createdOn
    if(representation[@"createdOn"]) {
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        [action setCreatedOn:[formatter dateFromString:representation[@"createdOn"]]];
    }
    // Subject handling (user or area)
    // @todo
    
    [self.dataAdapter save:nil];
    return action;
}

@end
