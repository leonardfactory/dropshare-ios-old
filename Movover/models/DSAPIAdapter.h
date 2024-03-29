//
//  DSWebApiAdapter.h
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface DSAPIAdapter : NSObject

+ (id) sharedAPIAdapter;

- (DSAPIAdapter *) initWithBaseURL:(NSString *)baseUrl;

- (void) setAccessToken:(NSString *) token;

// Queue method
- (void) requestWithMethod:(NSString *)method
                      path:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSDictionary *))success
                   failure:(void (^)(NSString *, int, NSError *))failure
                     queue:(NSString *)queueName;

- (void) postPath:(NSString *) path
withFormParameters:(NSDictionary *) parameters
          success:(void (^)(NSDictionary *responseObject)) success
          failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure;

- (void) postPath:(NSString *) path
	   parameters:(NSDictionary *) parameters
		  success:(void (^)(NSDictionary *responseObject)) success
		  failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure;

- (void) deletePath:(NSString *) path
            success:(void (^)(NSDictionary *responseObject)) success
            failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure;

- (void) getPath:(NSString *) path
	  parameters:(NSDictionary *) parameters
		 success:(void (^)(NSDictionary *responseObject)) success
		 failure:(void (^)(NSString *responseError, int statusCode, NSError *error)) failure;

- (void) postImage:(UIImage *) image toPath:(NSString *)path withName:(NSString *)name
		   success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
		   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure;

@end
