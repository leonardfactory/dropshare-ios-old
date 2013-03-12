//
//  DSWebApiAdapter.h
//  Model
//
//  Created by Francesco on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface DSWebApiAdapter : NSObject

@property (strong, nonatomic) AFHTTPClient *client;

- (DSWebApiAdapter *) initSSL;

- (DSWebApiAdapter *) initWithBaseUrl:baseUrl;

- (void) postPath:(NSString *) path
	   parameters:(NSDictionary *) parameters
		  success:(void (^)(NSDictionary *responseObject)) success
		  failure:(void (^)(NSString *responseError, NSError *error)) failure;

- (void) getPath:(NSString *) path
	  parameters:(NSDictionary *) parameters
		 success:(void (^)(NSDictionary *responseObject)) success
		 failure:(void (^)(NSString *responseError, NSError *error)) failure;

@end
