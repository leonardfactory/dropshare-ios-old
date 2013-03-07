//
//  DSProfileManager.m
//  Shabaka
//
//  Created by Francesco on 07/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSProfileManager.h"

@implementation DSProfileManager

- (DSEntityManager *) initWithViewController:(UIViewController *) viewController
{
	assert(viewController);
	self = [super initWithViewController:viewController];
	if (self)
	{
		[super setDomain:[[super dataAdapter] findOrCreate:@"profile" onModel:@"ProfileDomain"]];
	}
	[super setWebApiAdapter: [[DSWebApiAdapter alloc] initWithBaseUrl:@"https://francescoinfante.it"]];
	[super.domain addObserver:super.viewController forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:nil];
	[super.domain addObserver:super.viewController forKeyPath:@"error" options:NSKeyValueObservingOptionNew context:nil];
	return self;
}

- (BOOL) isLogged
{
	if ([(ProfileDomain *)super.domain user])
	{
		return TRUE;
	} else
	{
		return FALSE;
	}
}

- (void) loginWithUsername:(NSString *) username withPassword:(NSString *) password
{
	NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil];
	[super.webApiAdapter postPath:@"/login" parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"error code %d",[(id)[(id)operation response] statusCode]);
		[self.domain willChangeValueForKey:@"user"];
		NSString *identifier = [(NSDictionary *)responseObject objectForKey:@"id"];
		User *userLogged = [super.dataAdapter findOrCreate:identifier onModel:@"User"];
		[userLogged setName:[(NSDictionary *)responseObject objectForKey:@"name"]];
		[userLogged setSurname:[(NSDictionary *)responseObject objectForKey:@"surname"]];
		[userLogged setUsername:[(NSDictionary *)responseObject objectForKey:@"username"]];
		[(ProfileDomain *)super.domain setUser:userLogged];
		[super.dataAdapter save];
		[self.domain didChangeValueForKey:@"user"];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"error code %d",[(id)[(id)operation response] statusCode]);
	}];
}

- (BOOL) logout
{
	[(ProfileDomain *)super.domain setUser:nil];
	return [super.dataAdapter save];
}

@end
