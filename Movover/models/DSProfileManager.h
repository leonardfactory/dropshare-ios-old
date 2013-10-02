//
//  DSProfileManager.h
//  Movover
//
//  Created by @leonardfactory on 07/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSEntityManager.h"
#import "DSUserSerializer.h"

@interface DSProfileManager : DSEntityManager

@property BOOL isJustLogged;
@property (strong, nonatomic) Profile *profile;
@property (strong, nonatomic) NSString *errorString;
@property int statusCode;

- (void)saveCookies;

- (void)loadCookies;

- (BOOL) isLogged;

- (void) loginWithUsername:(NSString *) username withPassword:(NSString *) password;

- (void) logout;

@end
