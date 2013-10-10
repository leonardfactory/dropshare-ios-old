//
//  DSUserManager.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSUserManager.h"

@implementation DSUserManager

+ (instancetype) sharedManager
{
    static DSUserManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[[self class] alloc] init];
    });
    return _sharedManager;
}

- (DSUser *) userWithId:(NSString *)identifier
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(identifier = %@)", identifier];
    return (DSUser *)[self.dataAdapter findOneEntity:@"User" withPredicate:predicate];
}

@end
