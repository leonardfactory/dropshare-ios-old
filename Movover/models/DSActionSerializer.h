//
//  DSActionSerializer.h
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSSerializer.h"

#import "DSAction.h"

@interface DSActionSerializer : DSSerializer

- (DSAction *) deserializeActionFrom:(NSDictionary *) representation;

@end
