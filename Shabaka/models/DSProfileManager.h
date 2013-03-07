//
//  DSProfileManager.h
//  Shabaka
//
//  Created by Francesco on 07/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSEntityManager.h"

@interface DSProfileManager : DSEntityManager

- (BOOL) isLogged;

- (void) loginWithUsername:(NSString *) username withPassword:(NSString *) password;

- (BOOL) logout;

@end
