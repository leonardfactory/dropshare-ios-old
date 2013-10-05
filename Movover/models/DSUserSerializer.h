//
//  DSUserSerializer.h
//  Movover
//
//  Created by @leonardfactory on 13/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSDataAdapter.h"
#import "DSUser.h"

@interface DSUserSerializer : NSObject

@property (strong, nonatomic) DSDataAdapter *dataAdapter;

- (DSUser *) deserializeUserFrom:(NSDictionary *) dict;

@end
