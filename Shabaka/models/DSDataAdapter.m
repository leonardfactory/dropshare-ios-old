//
//  DSDataAdapter.m
//  Model
//
//  Created by Francesco on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSDataAdapter.h"

@implementation DSDataAdapter

@synthesize managedObjectContext = _managedObjectContext;

- (DSDataAdapter *) init
{
	_managedObjectContext = [(id)[[UIApplication sharedApplication] delegate] managedObjectContext];
	return self;
}

- (void) findOrCreate:(NSString *) identifier onModel:(NSString *) entityName
		   onComplete:(void (^)(id result)) completeBlock
			  onError:(NSManagedObjectContextFetchFailBlock) failBlock
{
	assert(identifier);
	assert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext]];
	[request setPredicate:[NSPredicate predicateWithFormat: @"identifier = %@", identifier]];
	
	[_managedObjectContext executeFetchRequestInBackground:request onComplete:^(NSArray *results) {
		for (id object in results)
		{
			completeBlock(object);
			return;
		}
		id createdObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext];
		[createdObject setIdentifier:identifier];
		[self save];
		completeBlock(createdObject);
		
	} onError:failBlock];
}

- (id) findOrCreate:(NSString *) identifier onModel:(NSString *) entityName
{
	assert(identifier);
	assert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext]];
	[request setPredicate:[NSPredicate predicateWithFormat: @"identifier = %@", identifier]];
	NSArray *result = [_managedObjectContext executeFetchRequest:request error:nil];
	for (id object in result)
	{
		return object;
	}
	id createdObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext];
	[createdObject setIdentifier:identifier];
	[self save];
	return createdObject;
}

- (void) remove:(id) object
{
	assert(object);
	[_managedObjectContext deleteObject:object];
	[self save];
}

- (BOOL) save
{
	return [_managedObjectContext save:nil];
}

@end
