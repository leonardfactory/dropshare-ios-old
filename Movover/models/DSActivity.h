//
//  DSActivity.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSSubject;

@interface DSActivity : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) id data;
@property (nonatomic, retain) NSString * objectEntity;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) DSSubject *subject;

@end
