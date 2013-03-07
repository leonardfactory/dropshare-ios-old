//
//  DSProfileManager.m
//  Shabaka
//
//  Created by Francesco on 07/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSProfileManager.h"

@implementation DSProfileManager

- (DSEntityManager *) init
{
	self = [super init];
	if (self)
	{
		[super setDomain:[[super dataAdapter] findOrCreate:@"profile" onModel:@"ProfileDomain"]];
	}
	[super setWebApiAdapter: [[DSWebApiAdapter alloc] initWithBaseUrl:@"https://francescoinfante.it"]];
	return self;
}

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
		[self.domain willChangeValueForKey:@"user"];
		NSDictionary *jsonFromData = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		
		NSString *identifier = [(NSDictionary *)jsonFromData objectForKey:@"id"];
		User *userLogged = [super.dataAdapter findOrCreate:identifier onModel:@"User"];
		[userLogged setName:[(NSDictionary *)jsonFromData objectForKey:@"name"]];
		[userLogged setSurname:[(NSDictionary *)jsonFromData objectForKey:@"surname"]];
		[userLogged setUsername:[(NSDictionary *)jsonFromData objectForKey:@"username"]];
		[(ProfileDomain *)super.domain setUser:userLogged];
		[super.dataAdapter save];
		[self.domain didChangeValueForKey:@"user"];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"%@",error);
	}];
}

- (BOOL) logout
{
	[(ProfileDomain *)super.domain setUser:nil];
	return [super.dataAdapter save];
}

@end
