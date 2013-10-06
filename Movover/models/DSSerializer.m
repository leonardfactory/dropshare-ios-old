//
//  DSSerializer.m
//  Movover
//
//  Basic class to handle Serialization & Deserialization to and
//  from JSON.
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSSerializer.h"

@implementation DSSerializer

- (DSSerializer *) init
{
    _dataAdapter = [DSDataAdapter sharedDataAdapter];
    return self;
}

@end
