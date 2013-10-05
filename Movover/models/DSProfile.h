//
//  DSProfile.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSUser;

@interface DSProfile : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) DSUser *user;

@end
