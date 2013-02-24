//
//  DSServerRequest.m
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSServerRequest.h"
#import "AFJSONRequestOperation.h"

@implementation DSServerRequest

@synthesize request = _request;

- (DSServerRequest *) initWithMethod:(NSString *)method withEntity:(NSString *)entity withIdentifier:(NSString *)identifier withParams:(NSDictionary *)params withBody:(NSDictionary *)body
{
	assert(entity);
	NSString * serverUrl = [NSString stringWithFormat:@"%@/%@", SERVERURL, entity];
	
	if (identifier)
	{
		serverUrl = [NSString stringWithFormat:@"%@/%@", serverUrl, identifier];
	}
	
	if (params)
	{
		BOOL first = TRUE;
		serverUrl = [NSString stringWithFormat:@"%@?", serverUrl];
		for (NSString* key in params)
		{
			if(first)
			{
				first = FALSE;
			}
			else
			{
				serverUrl = [NSString stringWithFormat:@"%@&", serverUrl];
			}
			id value = [params objectForKey:key];
			serverUrl = [NSString stringWithFormat:@"%@%@=%@", serverUrl, key, value];
		}
	}
	
	if (body)
	{
		//TODO body
	}
	
	NSURL *url = [NSURL URLWithString:serverUrl];
	_request = [NSMutableURLRequest requestWithURL:url];
	
	assert(method);
	[_request setHTTPMethod:method];
	
	return self;
}

- (void) doAndIfSuccess:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success elseIfFailure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{	
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:_request success:success failure: failure];
	[operation start];
}

@end
