//
//  DSEntityManager.h
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSDataAdapter.h"
#import "DSAPIAdapter.h"

@interface DSEntityManager : NSObject

+ (instancetype) sharedManager;

@property (strong, nonatomic) DSDataAdapter *dataAdapter;
@property (strong, nonatomic) DSAPIAdapter *APIAdapter;

@end
