//
//  DSEntityManager.m
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <objc/runtime.h>
#import "DSEntityManager.h"

@implementation DSEntityManager

@synthesize dataAdapter = _dataAdapter;
@synthesize APIAdapter = _APIAdapter;

+ (instancetype) sharedManager
{
    static DSEntityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[[self class] alloc] init];
    });
    return _sharedManager;
}

- (DSEntityManager *) init
{
	_dataAdapter    = [DSDataAdapter sharedDataAdapter];
    _APIAdapter     = [DSAPIAdapter sharedAPIAdapter];
	return self;
}


//+ (BOOL) resolveInstanceMethod:(SEL)aSEL
//{
//    if (aSEL == @selector(resolveThisMethodDynamically)) {
//        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:aSEL];
//}

@end
