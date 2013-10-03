//
//  DSUser.h
//  Movover
//
//  Created by Leonardo on 04/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSAction, DSComment, DSProfile, DSUser;

@interface DSUser : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * stringCreatedOn;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSOrderedSet *actions;
@property (nonatomic, retain) NSOrderedSet *followers;
@property (nonatomic, retain) NSOrderedSet *following;
@property (nonatomic, retain) DSProfile *inverseProfileUser;
@end

@interface DSUser (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(DSComment *)value;
- (void)removeCommentsObject:(DSComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)insertObject:(DSAction *)value inActionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromActionsAtIndex:(NSUInteger)idx;
- (void)insertActions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeActionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInActionsAtIndex:(NSUInteger)idx withObject:(DSAction *)value;
- (void)replaceActionsAtIndexes:(NSIndexSet *)indexes withActions:(NSArray *)values;
- (void)addActionsObject:(DSAction *)value;
- (void)removeActionsObject:(DSAction *)value;
- (void)addActions:(NSOrderedSet *)values;
- (void)removeActions:(NSOrderedSet *)values;
- (void)insertObject:(DSUser *)value inFollowersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFollowersAtIndex:(NSUInteger)idx;
- (void)insertFollowers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFollowersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFollowersAtIndex:(NSUInteger)idx withObject:(DSUser *)value;
- (void)replaceFollowersAtIndexes:(NSIndexSet *)indexes withFollowers:(NSArray *)values;
- (void)addFollowersObject:(DSUser *)value;
- (void)removeFollowersObject:(DSUser *)value;
- (void)addFollowers:(NSOrderedSet *)values;
- (void)removeFollowers:(NSOrderedSet *)values;
- (void)insertObject:(DSUser *)value inFollowingAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFollowingAtIndex:(NSUInteger)idx;
- (void)insertFollowing:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFollowingAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFollowingAtIndex:(NSUInteger)idx withObject:(DSUser *)value;
- (void)replaceFollowingAtIndexes:(NSIndexSet *)indexes withFollowing:(NSArray *)values;
- (void)addFollowingObject:(DSUser *)value;
- (void)removeFollowingObject:(DSUser *)value;
- (void)addFollowing:(NSOrderedSet *)values;
- (void)removeFollowing:(NSOrderedSet *)values;
@end
