//
//  DSUserSerializer.h
//  Movover
//
//  Created by @leonardfactory on 13/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSDataAdapter.h"

@interface DSUserSerializer : NSObject

@property (strong, nonatomic) DSDataAdapter *dataAdapter;

- (User *) deserializeUserFrom:(NSDictionary *) dict;

@end
