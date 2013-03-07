//
//  DSDataAdapter.h
//  Model
//
//  Created by Francesco on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSManagedObjectContext+blocks.h"
#import "User.h"
#import "Drop.h"
#import "ProfileDomain.h"

@interface DSDataAdapter : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void) findOrCreate:(NSString *) identifier onModel:(NSString *) entityName
		   onComplete:(void (^)(id result)) completeBlock
			  onError:(NSManagedObjectContextFetchFailBlock) failBlock;
- (id) findOrCreate:(NSString *) identifier onModel:(NSString *) entityName;
- (void) remove:(id) object;
- (BOOL) save;

@end
