//
//  DropCollection.h
//  Shabaka
//
//  Created by Francesco on 12/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop;

@interface DropCollection : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSOrderedSet *drops;
@end

@interface DropCollection (CoreDataGeneratedAccessors)

- (void)insertObject:(Drop *)value inDropsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDropsAtIndex:(NSUInteger)idx;
- (void)insertDrops:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDropsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDropsAtIndex:(NSUInteger)idx withObject:(Drop *)value;
- (void)replaceDropsAtIndexes:(NSIndexSet *)indexes withDrops:(NSArray *)values;
- (void)addDropsObject:(Drop *)value;
- (void)removeDropsObject:(Drop *)value;
- (void)addDrops:(NSOrderedSet *)values;
- (void)removeDrops:(NSOrderedSet *)values;
@end
