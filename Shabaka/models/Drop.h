//
//  Drop.h
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Drop : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSManagedObject *user;
@property (nonatomic, retain) NSSet *views;
@end

@interface Drop (CoreDataGeneratedAccessors)

- (void)addViewsObject:(NSManagedObject *)value;
- (void)removeViewsObject:(NSManagedObject *)value;
- (void)addViews:(NSSet *)values;
- (void)removeViews:(NSSet *)values;

@end
