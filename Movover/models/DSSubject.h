//
//  DSSubject.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DSActivity, DSArea, DSUser;

@interface DSSubject : NSManagedObject

@property (nonatomic, retain) NSString * ref;
@property (nonatomic, retain) DSArea *area;
@property (nonatomic, retain) DSUser *user;
@property (nonatomic, retain) DSActivity *inverseActivity;

@end
