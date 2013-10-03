//
//  DSDataAdapter.h
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSManagedObjectContext+blocks.h"
#import "User.h"
#import "Drop.h"
#import "Spacetag.h"
#import "Comment.h"
#import "Profile.h"
#import "DropCollection.h"

@interface DSDataAdapter : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void) findOrCreate:(NSString *) identifier onModel:(NSString *) entityName
		   onComplete:(void (^)(id result)) completeBlock
			  onError:(void (^)(NSError *error)) failBlock;

- (id) findOrCreate:(NSString *) identifier onModel:(NSString *) entityName error:(NSError **)error;

- (BOOL) remove:(id) object error:(NSError **)error;

- (BOOL) save:(NSError **)error;

@end