//
//  DSJournal.h
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSActivity;

@interface DSJournal : NSManagedObject

@property (nonatomic, retain) NSDate * updatedOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSOrderedSet *activities;
@end

@interface DSJournal (CoreDataGeneratedAccessors)

- (void)insertObject:(DSActivity *)value inActivitiesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromActivitiesAtIndex:(NSUInteger)idx;
- (void)insertActivities:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeActivitiesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInActivitiesAtIndex:(NSUInteger)idx withObject:(DSActivity *)value;
- (void)replaceActivitiesAtIndexes:(NSIndexSet *)indexes withActivities:(NSArray *)values;
- (void)addActivitiesObject:(DSActivity *)value;
- (void)removeActivitiesObject:(DSActivity *)value;
- (void)addActivities:(NSOrderedSet *)values;
- (void)removeActivities:(NSOrderedSet *)values;
@end
