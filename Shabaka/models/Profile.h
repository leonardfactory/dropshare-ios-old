//
//  Profile.h
//  Shabaka
//
//  Created by Francesco on 12/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop, User;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *likes;
@end

@interface Profile (CoreDataGeneratedAccessors)

- (void)addLikesObject:(Drop *)value;
- (void)removeLikesObject:(Drop *)value;
- (void)addLikes:(NSSet *)values;
- (void)removeLikes:(NSSet *)values;

@end
