//
//  DSWebApiAdapter.m
//  Model
//
//  Created by Francesco on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSWebApiAdapter.h"

@implementation DSWebApiAdapter

@synthesize client = _client;

- (DSWebApiAdapter *) init
{
	id serverUrl = [(id)[[UIApplication sharedApplication] delegate] serverUrl];
	_client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:serverUrl]];
	return self;
}

- (DSWebApiAdapter *) initWithBaseUrl:baseUrl
{
	assert(baseUrl);
	_client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
	return self;
}

- (void) postPath:(NSString *) path
	   parameters:(NSDictionary *) parameters
		  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
		  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure
{
	[_client postPath:path parameters:parameters success:success failure:failure];
}

- (void) getPath:(NSString *) path
     parameters:(NSDictionary *) parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure
{
	[_client getPath:path parameters:parameters success:success failure:failure];
}

@end
