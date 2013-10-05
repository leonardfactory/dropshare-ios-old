//
//  DSEntityManager.m
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSEntityManager.h"

@implementation DSEntityManager

@synthesize dataAdapter = _dataAdapter;
@synthesize APIAdapter = _APIAdapter;

- (DSEntityManager *) init
{
	_dataAdapter    = [[DSDataAdapter alloc] init];
    _APIAdapter     = [DSAPIAdapter sharedAPIAdapter];
	return self;
}

@end
