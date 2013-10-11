//
//  DSAction.h
//  Movover
//
//  Created by Leonardo on 11/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSArea, DSComment, DSUser;

@interface DSAction : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * imagePosted;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * like;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSNumber * statsComment;
@property (nonatomic, retain) NSNumber * statsLike;
@property (nonatomic, retain) NSNumber * statsReaction;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * subjectId;
@property (nonatomic, retain) NSString * subjectEntity;
@property (nonatomic, retain) DSArea *area;
@property (nonatomic, retain) NSOrderedSet *comments;
@property (nonatomic, retain) DSUser *likes;
@end

@interface DSAction (CoreDataGeneratedAccessors)

- (void)insertObject:(DSComment *)value inCommentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentsAtIndex:(NSUInteger)idx;
- (void)insertComments:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentsAtIndex:(NSUInteger)idx withObject:(DSComment *)value;
- (void)replaceCommentsAtIndexes:(NSIndexSet *)indexes withComments:(NSArray *)values;
- (void)addCommentsObject:(DSComment *)value;
- (void)removeCommentsObject:(DSComment *)value;
- (void)addComments:(NSOrderedSet *)values;
- (void)removeComments:(NSOrderedSet *)values;
@end
