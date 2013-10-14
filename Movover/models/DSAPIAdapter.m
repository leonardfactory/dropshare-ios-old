//
//  DSWebApiAdapter.m
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSAPIAdapter.h"
#import "DSJSONRequestBag.h"
#import "NSMutableArray+QueueAdditions.h"

static NSString * const kDSAPIBaseUrl       = @"http://api.movover.com/";
static NSString * const kDSAPISecureBaseUrl = @"https://api.movover.com/";

@interface DSAPIAdapter ()
{
    AFHTTPClient *_client;
    
    NSMutableDictionary *queues;
}

@end

@implementation DSAPIAdapter

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
	self = [self initWithBaseURL:kDSAPIBaseUrl];
	return self;
}

- (DSAPIAdapter *) initSSL
{
	self = [self initWithBaseURL:kDSAPISecureBaseUrl];
	return self;
}

- (DSAPIAdapter *) initWithBaseURL:(NSString *)baseURL
{
	_client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    
    [_client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [_client setDefaultHeader:@"Accept" value:@"application/json"];
    [_client setParameterEncoding:AFJSONParameterEncoding];
    
    queues = [[NSMutableDictionary alloc] init];
    
	return self;
}

#pragma mark - OAuth2.0

- (void) setAccessToken:(NSString *) token
{
    [_client setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", token]];
}

#pragma mark - API methods

- (void) postPath:(NSString *) path
withFormParameters:(NSDictionary *) parameters
          success:(void (^)(NSDictionary *responseObject)) success
          failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure
{
    [_client setParameterEncoding:AFFormURLParameterEncoding];
    [self postPath:path parameters:parameters success:success failure:failure];
    [_client setParameterEncoding:AFJSONParameterEncoding];
}

- (void) postPath:(NSString *) path
	   parameters:(NSDictionary *) parameters
		  success:(void (^)(NSDictionary *responseObject)) success
		  failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure
{
	[_client postPath:path parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject)
    {
		NSError *error;
        id dict = responseObject;
		//id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
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

- (void) deletePath:(NSString *) path
            success:(void (^)(NSDictionary *responseObject)) success
            failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure
{
    [_client deletePath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError *error;
        id dict = responseObject;
		if (dict) {
			success((NSDictionary *)dict);
		}
		else {
			failure(nil,0,error);
		}
    }
                failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        int code = [operation.response statusCode];
		NSString *errorString = operation.responseString;
		failure(errorString,code,error);
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
        id dict = responseObject;
		//id dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
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

#pragma mark - Supporting queues
- (void) requestWithMethod:(NSString *)method
                      path:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSDictionary *))success
                   failure:(void (^)(NSString *, int, NSError *))failure
                     queue:(NSString *)queueName
{
    if(![queues objectForKey:queueName])
    {
        [queues setObject:[NSMutableArray array] forKey:queueName];
    }
    
    NSMutableArray *queue = (NSMutableArray *)[queues objectForKey:queueName];
    
    BOOL processNow = [queue count] == 0;
    
    //NSLog(@"(Now: %d) Request: %@ | Queue: %@", processNow, path, queueName);
    
    __weak DSAPIAdapter *apiAdapter = self;
    
    void (^newSuccess)(NSDictionary *) = ^void (NSDictionary *dictionary)
    {
        success(dictionary);
        [apiAdapter processQueue:queueName];
    };
    
    void(^newFailure)(NSString *, int, NSError *) = ^void (NSString *s, int i, NSError *e)
    {
        failure(s, i, e);
        // @todo maybe block queue something like this
        [apiAdapter processQueue:queueName];
    };
    
    DSJSONRequestBag *requestBag = [[DSJSONRequestBag alloc] initWithMethod:method
                                                                       path:path
                                                                 parameters:parameters
                                                                    success:newSuccess
                                                                    failure:newFailure];
    [queue enqueue:requestBag];
    
    if(processNow)
    {
        if([method isEqualToString:@"GET"])
        {
            [self getPath:path parameters:parameters success:newSuccess failure:newFailure];
        }
        else if([method isEqualToString:@"POST"])
        {
            [self postPath:path parameters:parameters success:newSuccess failure:newFailure];
        }
        else if([method isEqualToString:@"DELETE"])
        {
            [self deletePath:path success:newSuccess failure:newFailure];
        }
        else
        {
            NSLog(@"Error unrecognized method.");
        }
    }
}

- (void) processQueue:(NSString *) queueName
{
    NSMutableArray *queue           = (NSMutableArray *)[queues objectForKey:queueName];
    
    if(!queue || [queue count] <= 1)
    {
        //NSLog(@"Cleaned queue: %@", queueName);
        // Queue has been completed. Remove it.
        [queues removeObjectForKey:queueName];
        return;
    }
    
    DSJSONRequestBag *oldRequestBag = [queue dequeue]; // Completed
    DSJSONRequestBag *requestBag    = (DSJSONRequestBag *)[queue peekHead];
    
    //NSLog(@"(From queue) Request: %@ | Queue: %@", requestBag.path, queueName);
    
    NSString *method = requestBag.method;
    
    if([method isEqualToString:@"GET"])
    {
        [self getPath:requestBag.path parameters:requestBag.parameters success:requestBag.success failure:requestBag.failure];
    }
    else if([method isEqualToString:@"POST"])
    {
        [self postPath:requestBag.path parameters:requestBag.parameters success:requestBag.success failure:requestBag.failure];
    }
    else if([method isEqualToString:@"DELETE"])
    {
        [self deletePath:requestBag.path success:requestBag.success failure:requestBag.failure];
    }
    else
    {
        NSLog(@"Error unrecognized method.");
    }
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
