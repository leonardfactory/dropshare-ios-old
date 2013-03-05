//
//  Drop.h
//  Shabaka
//
//  Created by Francesco on 05/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class JournalDomain, NewDropDomain, User;

@interface Drop : NSManagedObject

@property (nonatomic, retain) NSDate * createdOn;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) JournalDomain *journalDomain;
@property (nonatomic, retain) NewDropDomain *newDropDomain;
@property (nonatomic, retain) User *user;

@end
