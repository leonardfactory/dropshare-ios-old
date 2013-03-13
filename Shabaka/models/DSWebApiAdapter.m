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
	NSString * serverUrl = @"http://ec2-54-228-232-120.eu-west-1.compute.amazonaws.com/";
	_client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:serverUrl]];
	return self;
}

- (DSWebApiAdapter *) initSSL
{
	NSString * serverUrl = @"https://ec2-54-228-232-120.eu-west-1.compute.amazonaws.com/";
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
		  success:(void (^)(NSDictionary *responseObject)) success
		  failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure
{
	[_client postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSError *error;
		id dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
		if (dict)
		{
			success((NSDictionary *)dict);
		}
		else
		{
			failure(nil,0,error);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(operation.responseString,[operation.response statusCode],error);
	}];
}

- (void) getPath:(NSString *) path
     parameters:(NSDictionary *) parameters
		 success:(void (^)(NSDictionary *responseObject)) success
		 failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure
{
	[_client getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSError *error;
		id dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
		if (dict)
		{
			success((NSDictionary *)dict);
		}
		else
		{
			failure(nil,0,error);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		int code = [operation.response statusCode];
		NSString *errorString = operation.responseString;
		failure(errorString,code,error);
	}];
}

@end
