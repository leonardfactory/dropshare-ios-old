//
//  DSAreaSerializer.m
//  Movover
//
//  Created by Leonardo on 09/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSAreaSerializer.h"

@implementation DSAreaSerializer

- (DSArea *) deserializeAreaFrom:(NSDictionary *)representation
{
    // _id & fetching
    NSString *identifier = representation[@"_id"];
    
    DSArea *area = [self.dataAdapter findOrCreate:identifier onModel:@"Area" error:nil];
    
    NSString *name = representation[@"name"];
    if(name == (id)[NSNull null] || name.length == 0) {
        name = @"";
    }
    
    [area setValue:name forKey:@"name"];
    
    NSDictionary *center = representation[@"center"];
    if(center) {
        [area setLatitude:center[@"lat"]];
        [area setLongitude:center[@"lon"]];
    }
    
    [self.dataAdapter save:nil];
    return area;
}

@end
