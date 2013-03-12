//
//  User.h
//  Shabaka
//
//  Created by Francesco on 12/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Drop, Profile, Spacetag, User;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSOrderedSet *drops;
@property (nonatomic, retain) NSOrderedSet *followers;
@property (nonatomic, retain) NSOrderedSet *following;
@property (nonatomic, retain) Profile *inverseProfileUser;
@property (nonatomic, retain) NSOrderedSet *spacetags;
@property (nonatomic, retain) NSSet *comments;
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
- (void)insertObject:(User *)value inFollowingAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFollowingAtIndex:(NSUInteger)idx;
- (void)insertFollowing:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFollowingAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFollowingAtIndex:(NSUInteger)idx withObject:(User *)value;
- (void)replaceFollowingAtIndexes:(NSIndexSet *)indexes withFollowing:(NSArray *)values;
- (void)addFollowingObject:(User *)value;
- (void)removeFollowingObject:(User *)value;
- (void)addFollowing:(NSOrderedSet *)values;
- (void)removeFollowing:(NSOrderedSet *)values;
- (void)insertObject:(Spacetag *)value inSpacetagsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSpacetagsAtIndex:(NSUInteger)idx;
- (void)insertSpacetags:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSpacetagsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSpacetagsAtIndex:(NSUInteger)idx withObject:(Spacetag *)value;
- (void)replaceSpacetagsAtIndexes:(NSIndexSet *)indexes withSpacetags:(NSArray *)values;
- (void)addSpacetagsObject:(Spacetag *)value;
- (void)removeSpacetagsObject:(Spacetag *)value;
- (void)addSpacetags:(NSOrderedSet *)values;
- (void)removeSpacetags:(NSOrderedSet *)values;
- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
