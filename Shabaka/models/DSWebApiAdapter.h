//
//  DSWebApiAdapter.h
//  Model
//
//  Created by Francesco on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface DSWebApiAdapter : NSObject

@property (strong, nonatomic) AFHTTPClient *client;

- (DSWebApiAdapter *) initWithBaseUrl:baseUrl;

- (void) postPath:(NSString *) path parameters:(NSDictionary *) params
		  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
		  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) getPath:(NSString *) path
	  parameters:(NSDictionary *) parameters
		 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject)) success
		 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error)) failure;

@end
