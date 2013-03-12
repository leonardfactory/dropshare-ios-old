//
//  Drop.h
//  Shabaka
//
//  Created by Francesco on 12/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, DropCollection, Profile, Spacetag, User;

@interface Drop : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * totComments;
@property (nonatomic, retain) NSNumber * totLikes;
@property (nonatomic, retain) NSNumber * totRedrops;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) Profile *inverseProfileLikes;
@property (nonatomic, retain) NSSet *inverseDropCollectionDrops;
@property (nonatomic, retain) NSSet *spacetags;
@property (nonatomic, retain) NSOrderedSet *comments;
@end

@interface Drop (CoreDataGeneratedAccessors)

- (void)addInverseDropCollectionDropsObject:(DropCollection *)value;
- (void)removeInverseDropCollectionDropsObject:(DropCollection *)value;
- (void)addInverseDropCollectionDrops:(NSSet *)values;
- (void)removeInverseDropCollectionDrops:(NSSet *)values;

- (void)addSpacetagsObject:(Spacetag *)value;
- (void)removeSpacetagsObject:(Spacetag *)value;
- (void)addSpacetags:(NSSet *)values;
- (void)removeSpacetags:(NSSet *)values;

- (void)insertObject:(Comment *)value inCommentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentsAtIndex:(NSUInteger)idx;
- (void)insertComments:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentsAtIndex:(NSUInteger)idx withObject:(Comment *)value;
- (void)replaceCommentsAtIndexes:(NSIndexSet *)indexes withComments:(NSArray *)values;
- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSOrderedSet *)values;
- (void)removeComments:(NSOrderedSet *)values;
@end
