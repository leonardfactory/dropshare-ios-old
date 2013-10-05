//
//  DSProfileManager.h
//  Movover
//
//  Created by @leonardfactory on 07/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSEntityManager.h"
#import "DSUserSerializer.h"
#import "DSToken.h"

@interface DSTokenManager : DSEntityManager

@property BOOL isJustLogged;
@property (strong, nonatomic) DSToken *token;
@property (strong, nonatomic) NSString *errorString;
@property int statusCode;

- (BOOL) isAccessTokenAvailable;

- (void) getAccessTokenWithUsername:(NSString *) username andPassword:(NSString *) password;

- (void) revokeAccessToken;

@end
