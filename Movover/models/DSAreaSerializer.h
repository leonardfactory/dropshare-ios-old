//
//  DSAreaSerializer.h
//  Movover
//
//  Created by Leonardo on 09/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSSerializer.h"
#import "DSArea.h"

@interface DSAreaSerializer : DSSerializer

- (DSArea *) deserializeAreaFrom:(NSDictionary *)representation;

@end
