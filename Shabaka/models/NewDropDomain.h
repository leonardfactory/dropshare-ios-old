//
//  NewDropDomain.h
//  Shabaka
//
//  Created by Francesco on 05/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Drop;

@interface NewDropDomain : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) Drop *newDrop;

@end
