//
//  DSProfileManager.m
//  Movover
//
//  Created by @leonardfactory on 07/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSProfileManager.h"

@implementation DSProfileManager

- (DSEntityManager *) init
{
	self = [super init];
	if (self)
	{
		[self setProfile:[[super dataAdapter] findOrCreate:@"profile" onModel:@"Profile" error:nil]];
		self.isJustLogged = FALSE;
		[self setWebApiAdapter: [[DSWebApiAdapter alloc] initSSL]];
	}
	return self;
}

- (BOOL) isLogged
{
	if ([_profile user])
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

- (void) loginWithUsername:(NSString *) username withPassword:(NSString *) password
{
	assert(username);
	assert(password);
	NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil];
	[self.webApiAdapter postPath:@"/login" parameters:body success:^(NSDictionary *responseObject)
	{
		_statusCode = 200;
		if ([responseObject objectForKey:@"error"])
		{
			[self setErrorString:[responseObject objectForKey:@"error"]];
		}
		else
		{
			DSUserSerializer *serializer = [[DSUserSerializer alloc] init];
			[_profile setUser:[serializer deserializeUserFrom:responseObject]];
			[self.dataAdapter save:nil];
			self.isJustLogged = TRUE;
		}
	} failure:^(NSString *responseError, int statusCode, NSError *error)
	{
		_statusCode = statusCode;
		[self setErrorString:responseError];
	}];
}

- (void) logout
{
	[self.webApiAdapter postPath:@"/logout" parameters:nil success:^(NSDictionary *responseObject) {
		NSLog(@"%@",[responseObject objectForKey:@"result"]);
	} failure:^(NSString *responseError, int statusCode, NSError *error) {
		NSLog(@"Failed to log out remotely: %@",responseError);
	}];
	[_profile setUser:nil];
	[super.dataAdapter save:nil];
}

- (void)saveCookies
{
	
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: cookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
}

- (void)loadCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
	
}

@end
