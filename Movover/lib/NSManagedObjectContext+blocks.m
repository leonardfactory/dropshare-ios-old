#import "NSManagedObjectContext+blocks.h"

@implementation NSManagedObjectContext (NSManagedObjectContext_blocks)

-(void)executeFetchRequestInBackground:(NSFetchRequest*) aRequest 
							onComplete:(NSManagedObjectContextFetchCompleteBlock) completeBlock 
							   onError:(NSManagedObjectContextFetchFailBlock) failBlock{
	
	//Get the persistent store coordinator
	//NSPersistentStoreCoordinator	*coordinator = [self persistentStoreCoordinator];
	
	dispatch_queue_t	backgroundQueue	= dispatch_queue_create("FR.NSManagedObjectContext.fetchRequests", NULL);
	dispatch_queue_t	mainQueue		= dispatch_get_main_queue();
	
	//Change the fetch result type to object ids
	[aRequest setResultType:NSManagedObjectIDResultType];
	
	//Create a new context
	dispatch_async(backgroundQueue, ^{
		
		//Create a new managed object context
		NSManagedObjectContext	*threadContext;
		NSArray					*threadResults = nil;
		NSMutableArray			*results = nil;
		NSError					*error = nil;
		
		threadContext = [[NSManagedObjectContext alloc] init];
		
		[threadContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
		
		if( (threadResults = [threadContext executeFetchRequest:aRequest error:&error]) ){
			
			//Create a new array to place the results in
			results = [[NSMutableArray alloc] initWithCapacity:[threadResults count]];
			
			//Call on the main thread
			dispatch_sync(mainQueue, ^{

				//Iterate over the objects
				//Re assign the objects to the correct (main) context
				[threadResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *halt){
					
					[results addObject:[self objectWithID:obj]];
					
				}];				
				
				completeBlock(results);
				
			});
		
		}
		else{
			
			//Call on the main thread
			dispatch_sync(mainQueue, ^{
				failBlock( error );				
			});
		}
	});
}

@end
