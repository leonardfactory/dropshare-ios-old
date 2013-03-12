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
		//[super setDomain:[[super dataAdapter] findOrCreate:@"profile" onModel:@"ProfileDomain"]];
	}
	self.isJustLogged = FALSE;
	[super setWebApiAdapter: [[DSWebApiAdapter alloc] initWithBaseUrl:@"https://francescoinfante.it"]];
	return self;
}

- (DSEntityManager *) initWithViewController:(UIViewController *) viewController
{
	assert(viewController);
	self = [super initWithViewController:viewController];
	if (self)
	{
		//[super setDomain:[[super dataAdapter] findOrCreate:@"profile" onModel:@"ProfileDomain"]];
	}
	[super setWebApiAdapter: [[DSWebApiAdapter alloc] initWithBaseUrl:@"https://francescoinfante.it"]];
	[super.domain addObserver:super.viewController forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:nil];
	[super.domain addObserver:super.viewController forKeyPath:@"error" options:NSKeyValueObservingOptionNew context:nil];
	return self;
}

- (BOOL) isLogged
{/*
	if ([(ProfileDomain *)super.domain user])
	{
		return TRUE;
	} else
	{
		return FALSE;
	}
  */
	return FALSE;
}

- (void) loginWithUsername:(NSString *) username withPassword:(NSString *) password
{
	
}
/*
- (void) loginWithUsername:(NSString *) username withPassword:(NSString *) password
{
	//NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil];
	//[super.webApiAdapter postPath:@"/login" parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
		//NSDictionary *jsonFromData = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
		
		//NSString *identifier = [jsonFromData objectForKey:@"id"];
		User *userLogged = [super.dataAdapter findOrCreate:identifier onModel:@"User"];
		[userLogged setName:[jsonFromData objectForKey:@"name"]];
		[userLogged setSurname:[jsonFromData objectForKey:@"surname"]];
		[userLogged setUsername:[jsonFromData objectForKey:@"username"]];
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
		[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		
		NSDate *myDate = [dateFormatter dateFromString:[[jsonFromData objectForKey:@"createdOn"] substringToIndex:19]];
		
		[userLogged setCreatedOn:myDate];
		self.isJustLogged = TRUE;
		//[(ProfileDomain *)super.domain setUser:userLogged];
		//[super.dataAdapter save];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
		NSError *errorJson = nil;
		if(operation.responseData)
		{
			NSDictionary *jsonFromData = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&errorJson];
			if (!errorJson)
			{
				//[(ProfileDomain *)super.domain setError:[jsonFromData objectForKey:@"error"]];
			}
			else
			{
				//[(ProfileDomain *)super.domain setError:[NSString stringWithFormat:@"%@",operation.responseString]];
			}
		}
		else
		{
			//[(ProfileDomain *)super.domain setError:[error localizedDescription]];
		}
		//[super.dataAdapter save];
	}];
}
 */

- (BOOL) logout
{
	//[(ProfileDomain *)super.domain setUser:nil];
	//return [super.dataAdapter save];
	return FALSE;
}

@end
