//
//  Profile.h
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) User *user;

@end
