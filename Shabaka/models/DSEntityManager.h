//
//  DSEntityManager.h
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSEntityManager : NSObject

+ (id) getProperty:(NSString *)propertyName ofEntity:(NSString *)entityName withIdentifier:(NSString *)identifier;

+ (void) updateProperty:(NSString *)propertyName ofEntity:(NSString *)entityName withIdentifier:(NSString *)identifier;

@end
