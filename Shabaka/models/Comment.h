//
//  Comment.h
//  Shabaka
//
//  Created by Francesco on 12/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop, User;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Drop *drop;
@property (nonatomic, retain) User *user;

@end
