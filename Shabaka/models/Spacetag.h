//
//  Spacetag.h
//  Shabaka
//
//  Created by Francesco on 12/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop, User;

@interface Spacetag : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * range;
@property (nonatomic, retain) NSString * spacename;
@property (nonatomic, retain) NSNumber * totUsers;
@property (nonatomic, retain) NSOrderedSet *users;
@property (nonatomic, retain) NSOrderedSet *drops;
@end

@interface Spacetag (CoreDataGeneratedAccessors)

- (void)insertObject:(User *)value inUsersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromUsersAtIndex:(NSUInteger)idx;
- (void)insertUsers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeUsersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInUsersAtIndex:(NSUInteger)idx withObject:(User *)value;
- (void)replaceUsersAtIndexes:(NSIndexSet *)indexes withUsers:(NSArray *)values;
- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSOrderedSet *)values;
- (void)removeUsers:(NSOrderedSet *)values;
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
