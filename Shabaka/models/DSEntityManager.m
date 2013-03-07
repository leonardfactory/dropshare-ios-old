//
//  DSEntityManager.m
//  Model
//
//  Created by Francesco on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSEntityManager.h"

@implementation DSEntityManager

@synthesize dataAdapter = _dataAdapter;
@synthesize webApiAdapter = _webApiAdapter;
@synthesize viewController = _viewController;

- (DSEntityManager *) initWithViewController:(UIViewController *) viewController
{
	assert(viewController);
	_viewController = viewController;
	_dataAdapter = [[DSDataAdapter alloc] init];
	return self;
}

@end
