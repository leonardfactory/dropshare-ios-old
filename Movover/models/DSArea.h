//
//  DSArea.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSAction, DSUser;

@interface DSArea : NSManagedObject

@property (nonatomic, retain) NSNumber * approved;
@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * radius;
@property (nonatomic, retain) NSNumber * statsFollowers;
@property (nonatomic, retain) NSOrderedSet *actions;
@property (nonatomic, retain) NSOrderedSet *followers;
@end

@interface DSArea (CoreDataGeneratedAccessors)

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
@end
