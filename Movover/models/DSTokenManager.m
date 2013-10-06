//
//  DSProfileManager.m
//  Movover
//
//  Created by @leonardfactory on 07/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSTokenManager.h"

@implementation DSTokenManager

- (DSTokenManager *) init
{
	self = [super init];
	if (self)
	{
		[self setToken:[[super dataAdapter] findOrCreate:@"Token" onModel:@"Token" error:nil]];
		self.isJustLogged = FALSE;
	}
	return self;
}

- (void) getAccessTokenWithUsername:(NSString *) username andPassword:(NSString *) password
{
    assert(username);
	assert(password);
    
	NSDictionary *body = @{@"username": username, @"password": password, @"grant_type": @"password" };
    
	[self.APIAdapter postPath:@"/user/token" withFormParameters:body success:^(NSDictionary *responseObject)
     {
         // Token got!
         [_token setAccessToken:responseObject[@"access_token"]];
         [self.APIAdapter setAccessToken:_token.accessToken];
         
         // Now check for user id, and see if token is valid
         [self.APIAdapter getPath:@"/user/check" parameters:nil success:^(NSDictionary *responseObject)
         {
             NSString *identifier = responseObject[@"_id"];
             [self.APIAdapter getPath:[NSString stringWithFormat:@"/user/%@/profile", identifier] parameters:nil success:^(NSDictionary *responseObject)
             {
                 DSUserSerializer *serializer = [[DSUserSerializer alloc] init];
                 // Fix this server side.
                 NSDictionary *responseWithIdentifier = [responseObject[@"user"] mutableCopy];
                 [responseWithIdentifier setValue:identifier forKey:@"_id"];
                 [_token setUser:[serializer deserializeUserFrom:responseWithIdentifier]];
                 
                 // APIAdapter with OAuth
                 
                 [self.dataAdapter save:nil];
                 self.isJustLogged = TRUE;
                 
             } failure:^(NSString *responseError, int statusCode, NSError *error)
             {
                 _statusCode = statusCode;
                 [self setErrorString:responseError];
             }];
             
         } failure:^(NSString *responseError, int statusCode, NSError *error)
         {
             _statusCode = statusCode;
             [self setErrorString:responseError];
         }];
         
         [self.dataAdapter save:nil];
         
     } failure:^(NSString *responseError, int statusCode, NSError *error)
     {
         _statusCode = statusCode;
         [self setErrorString:responseError];
     }];

}

- (BOOL) isAccessTokenAvailable
{
	if ([_token accessToken]) {
		return TRUE;
	}
	else {
		return FALSE;
	}
}

- (void) revokeAccessToken
{
    [_token setAccessToken:nil];
    [_token setUser:nil];
    [super.dataAdapter save:nil];
}

@end
