//
//  User.h
//  Shabaka
//
//  Created by Francesco on 07/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop, User;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSOrderedSet *drops;
@property (nonatomic, retain) NSOrderedSet *followed;
@property (nonatomic, retain) NSOrderedSet *followers;
@end

@interface User (CoreDataGeneratedAccessors)

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
- (void)insertObject:(User *)value inFollowedAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFollowedAtIndex:(NSUInteger)idx;
- (void)insertFollowed:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFollowedAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFollowedAtIndex:(NSUInteger)idx withObject:(User *)value;
- (void)replaceFollowedAtIndexes:(NSIndexSet *)indexes withFollowed:(NSArray *)values;
- (void)addFollowedObject:(User *)value;
- (void)removeFollowedObject:(User *)value;
- (void)addFollowed:(NSOrderedSet *)values;
- (void)removeFollowed:(NSOrderedSet *)values;
- (void)insertObject:(User *)value inFollowersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFollowersAtIndex:(NSUInteger)idx;
- (void)insertFollowers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFollowersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFollowersAtIndex:(NSUInteger)idx withObject:(User *)value;
- (void)replaceFollowersAtIndexes:(NSIndexSet *)indexes withFollowers:(NSArray *)values;
- (void)addFollowersObject:(User *)value;
- (void)removeFollowersObject:(User *)value;
- (void)addFollowers:(NSOrderedSet *)values;
- (void)removeFollowers:(NSOrderedSet *)values;
@end
