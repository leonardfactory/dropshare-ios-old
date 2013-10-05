//
//  DSWebApiAdapter.m
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSAPIAdapter.h"

static NSString * const kDSAPIBaseUrl       = @"http://api.movover.com/";
static NSString * const kDSAPISecureBaseUrl = @"https://api.movover.com/";

@implementation DSAPIAdapter

@synthesize client = _client;

+ (id) sharedAPIAdapter
{
    static DSAPIAdapter *_sharedAPIAdapter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAPIAdapter = [[self alloc] init];
    });
    
    return _sharedAPIAdapter;
}

- (DSAPIAdapter *) init
{
	_client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kDSAPIBaseUrl]];
	return self;
}

- (DSAPIAdapter *) initSSL
{
	_client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kDSAPISecureBaseUrl]];
	return self;
}

- (DSAPIAdapter *) initWithBaseUrl:(NSString *)baseUrl
{
	_client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    
    [_client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [_client setDefaultHeader:@"Accept" value:@"application/json"];
    
	return self;
}

#pragma mark - OAuth2.0

- (void) setAccessToken:(NSString *) token
{
    [_client setAuthorizationHeaderWithToken:token];
}

#pragma mark - API methods

- (void) postPath:(NSString *) path
	   parameters:(NSDictionary *) parameters
		  success:(void (^)(NSDictionary *responseObject)) success
		  failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure
{
	[_client postPath:path parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
		NSError *error;
		id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
		if (dict) {
			success((NSDictionary *)dict);
		}
		else {
			failure(nil, 0, error);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
		failure(operation.responseString, [operation.response statusCode] ,error);
	}];
}

- (void) getPath:(NSString *) path
     parameters:(NSDictionary *) parameters
		 success:(void (^)(NSDictionary *responseObject)) success
		 failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure
{
	[_client getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
		NSError *error;
		id dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
		if (dict) {
			success((NSDictionary *)dict);
		}
		else {
			failure(nil,0,error);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
		int code = [operation.response statusCode];
		NSString *errorString = operation.responseString;
		failure(errorString,code,error);
	}];
}

- (void) postImage:(UIImage *) image toPath:(NSString *)path withName:(NSString *)name
		   success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
		   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
	NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
	NSURLRequest *request = [_client multipartFormRequestWithMethod:@"POST" path:path parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
		[formData appendPartWithFileData:imageData
									name:name
								fileName:@"image1.jpg"
								mimeType:@"image/jpeg"];
	}];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:success failure:failure];
	[operation start];
}

@end
