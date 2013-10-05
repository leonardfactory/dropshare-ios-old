//
//  DSFetchRequest.h
//  Movover
//
//  Created by Leonardo on 04/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface DSFetchRequest : NSFetchRequest

@property (strong, nonatomic) NSDictionary *parameters;

@end
