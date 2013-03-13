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
			  onError:(void (^)(NSError *error)) failBlock
{
	assert(identifier);
	assert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext]];
	[request setPredicate:[NSPredicate predicateWithFormat: @"identifier = %@", identifier]];
	
	[_managedObjectContext executeFetchRequestInBackground:request onComplete:^(NSArray *results) {
		for (id object in results)
		{
			//Call the callback with the first and only entry.
			completeBlock(object);
			return;
		}
		id createdObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext];
		[createdObject setIdentifier:identifier];
		NSError *error;
		if(![self save:&error])
		{
			failBlock(error);
		}
		else
		{
			completeBlock(createdObject);
		}
	} onError:failBlock];
}

- (id) findOrCreate:(NSString *) identifier onModel:(NSString *) entityName error:(NSError **)error;
{
	assert(identifier);
	assert(entityName);
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext]];
	[request setPredicate:[NSPredicate predicateWithFormat: @"identifier = %@", identifier]];
	NSArray *result = [_managedObjectContext executeFetchRequest:request error:error];
	if(!result)
	{
		return nil;
	}
	for (id object in result)
	{
		//Return the first and only entry.
		return object;
	}
	//Or create a new one.
	id createdObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext];
	[createdObject setIdentifier:identifier];
	if(![self save:error])
	{
		return nil;
	}
	return createdObject;
}

- (BOOL) remove:(id) object error:(NSError **)error
{
	assert(object);
	[_managedObjectContext deleteObject:object];
	return [_managedObjectContext save:error];
}

- (BOOL) save:(NSError **)error
{
	return [_managedObjectContext save:error];
}

@end
