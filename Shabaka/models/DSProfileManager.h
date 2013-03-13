//
//  DSProfileManager.h
//  Shabaka
//
//  Created by Francesco on 07/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSEntityManager.h"
#import "DSUserSerializer.h"

@interface DSProfileManager : DSEntityManager

@property BOOL isJustLogged;
@property (strong, nonatomic) Profile *profile;
@property (strong, nonatomic) NSString *errorString;
@property int statusCode;

- (BOOL) isLogged;

- (void) loginWithUsername:(NSString *) username withPassword:(NSString *) password;

- (void) logout;

@end
