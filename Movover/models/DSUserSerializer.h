//
//  DSUserSerializer.h
//  Movover
//
//  Created by @leonardfactory on 13/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSSerializer.h"
#import "DSUser.h"

@interface DSUserSerializer : DSSerializer

- (DSUser *) deserializeUserFrom:(NSDictionary *) dict;

@end
