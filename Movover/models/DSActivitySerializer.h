//
//  DSActivitySerializer.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DSSerializer.h"
#import "DSActivity.h"

@interface DSActivitySerializer : DSSerializer

- (DSActivity *) deserializeActivityFrom:(NSDictionary *) representation;

@end
