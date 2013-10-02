//
//  DSDropSerializer.h
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSDataAdapter.h"
#import "DSUserSerializer.h"

@interface DSDropSerializer : NSObject

@property (strong, nonatomic) DSDataAdapter *dataAdapter;

- (void) deserializeDropSetFrom:(NSArray *) array intoDropCollection:(DropCollection *) collection;

- (int) deserializeDropSetFrom:(NSArray *) array appendIntoDropCollection:(DropCollection *) collection;

- (Drop *) deserializeDropFrom:(NSDictionary *) dict;

@end
