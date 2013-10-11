//
//  DSDataAdapter.m
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSDataAdapter.h"

@implementation DSDataAdapter

@synthesize managedObjectContext = _managedObjectContext;

+ (id) sharedDataAdapter
{
    static DSDataAdapter *_sharedDataAdapter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataAdapter = [[self alloc] init];
    });
    
    return _sharedDataAdapter;
}

- (DSDataAdapter *) init
{
	_managedObjectContext = [(id)[[UIApplication sharedApplication] delegate] managedObjectContext];
	return self;
}

#pragma mark - Core Data backing methods

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

- (id) findOneEntity:(NSString *) entityName withPredicate:(NSPredicate *) predicate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSArray *result = [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if(!result) {
        return nil;
    }
    
    return [result firstObject];
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
		
		//NSLog(@"%@",object);
		return object;
	}
	//Or create a new one.
	id createdObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_managedObjectContext];
	[createdObject setIdentifier:identifier];
	if(![self save:error])
	{
		return nil;
	}
	
	//NSLog(@"%@",createdObject);
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
    NSLog(@"%@", *error);
}

@end
