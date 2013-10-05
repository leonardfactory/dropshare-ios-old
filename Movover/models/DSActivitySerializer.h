//
//  DSActivitySerializer.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DSDataAdapter.h"
#import "DSActivity.h"

@interface DSActivitySerializer : NSObject

@property (strong, nonatomic) DSDataAdapter *dataAdapter;

- (DSActivity *) deserializeActivityFrom:(NSDictionary *) representation;

@end
