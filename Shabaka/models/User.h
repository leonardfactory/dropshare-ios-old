//
//  User.h
//  Shabaka
//
//  Created by Francesco on 05/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop, User;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * lastKnownLocation;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *drops;
@property (nonatomic, retain) NSSet *followed;
@property (nonatomic, retain) NSSet *followers;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addDropsObject:(Drop *)value;
- (void)removeDropsObject:(Drop *)value;
- (void)addDrops:(NSSet *)values;
- (void)removeDrops:(NSSet *)values;

- (void)addFollowedObject:(User *)value;
- (void)removeFollowedObject:(User *)value;
- (void)addFollowed:(NSSet *)values;
- (void)removeFollowed:(NSSet *)values;

- (void)addFollowersObject:(User *)value;
- (void)removeFollowersObject:(User *)value;
- (void)addFollowers:(NSSet *)values;
- (void)removeFollowers:(NSSet *)values;

@end
