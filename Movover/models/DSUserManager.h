//
//  DSUserManager.h
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSEntityManager.h"
#import "DSUser.h"

@interface DSUserManager : DSEntityManager

- (DSUser *) userWithId:(NSString *)identifier;

@end
