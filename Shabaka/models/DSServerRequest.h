//
//  DSServerRequest.h
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFJSONRequestOperation.h"

@interface DSServerRequest : NSObject

- (DSServerRequest *) initWithMethod:(NSString *)method withURL:(NSString *)url withParams:(NSDictionary *)params withBody:(NSDictionary *)body;

- (void) doAndIfSuccess:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success elseIfFailure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure;

@end
