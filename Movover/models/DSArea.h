//
//  DSArea.h
//  Movover
//
//  Created by Leonardo on 04/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSAction, DSUser;

@interface DSArea : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * range;
@property (nonatomic, retain) NSString * spacename;
@property (nonatomic, retain) NSNumber * totUsers;
@property (nonatomic, retain) NSOrderedSet *actions;
@property (nonatomic, retain) NSOrderedSet *users;
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
- (void)insertObject:(DSUser *)value inUsersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromUsersAtIndex:(NSUInteger)idx;
- (void)insertUsers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeUsersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInUsersAtIndex:(NSUInteger)idx withObject:(DSUser *)value;
- (void)replaceUsersAtIndexes:(NSIndexSet *)indexes withUsers:(NSArray *)values;
- (void)addUsersObject:(DSUser *)value;
- (void)removeUsersObject:(DSUser *)value;
- (void)addUsers:(NSOrderedSet *)values;
- (void)removeUsers:(NSOrderedSet *)values;
@end
