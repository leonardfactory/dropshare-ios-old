//
//  DSUserManager.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSUserManager.h"

@implementation DSUserManager

- (DSUser *) userWithId:(NSString *)identifier
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objectID = %@)", identifier];
    return (DSUser *)[self.dataAdapter findOneEntity:@"User" withPredicate:predicate];
}

@end
