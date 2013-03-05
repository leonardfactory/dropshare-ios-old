#import <Foundation/Foundation.h>

typedef void (^NSManagedObjectContextFetchCompleteBlock)(NSArray* results);
typedef void (^NSManagedObjectContextFetchFailBlock)(NSError *error);

@interface NSManagedObjectContext (NSManagedObjectContext_blocks)


-(void)executeFetchRequestInBackground:(NSFetchRequest*) aRequest 
							onComplete:(NSManagedObjectContextFetchCompleteBlock) completeBlock 
							   onError:(NSManagedObjectContextFetchFailBlock) failBlock;

@end