//
//  DSComment.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSAction, DSUser;

@interface DSComment : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) DSAction *action;
@property (nonatomic, retain) DSUser *user;

@end
