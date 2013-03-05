//
//  JournalDomain.h
//  Shabaka
//
//  Created by Francesco on 05/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop;

@interface JournalDomain : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSSet *drops;
@end

@interface JournalDomain (CoreDataGeneratedAccessors)

- (void)addDropsObject:(Drop *)value;
- (void)removeDropsObject:(Drop *)value;
- (void)addDrops:(NSSet *)values;
- (void)removeDrops:(NSSet *)values;

@end
