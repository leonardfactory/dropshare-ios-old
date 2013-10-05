//
//  DSJournal.h
//  Movover
//
//  Created by Leonardo on 05/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DSJournal : NSManagedObject

@property (nonatomic, retain) NSDate * updatedOn;
@property (nonatomic, retain) NSManagedObject *activities;

@end
