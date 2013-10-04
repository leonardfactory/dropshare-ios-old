//
//  DSIncrementalStore.m
//  Movover
//
//  Created by Leonardo on 04/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSIncrementalStore.h"
#import "DSAPIClient.h"

@implementation DSIncrementalStore

+ (void) initialize
{
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *) type
{
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *) model
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"Movover" withExtension:@"xcdatamodeld"]];
}

- (id<AFIncrementalStoreHTTPClient>) HTTPClient
{
    return [DSAPIClient sharedClient];
}

@end
