//
//  DSServerRequest.h
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SERVERURL @"http://192.168.0.102"

@interface DSServerRequest : NSObject

@property (strong, nonatomic) NSMutableURLRequest *request;

- (DSServerRequest *) initWithMethod:(NSString *)method withEntity:(NSString *)entity withIdentifier:(NSString *)identifier withParams:(NSDictionary *)params withBody:(NSDictionary *)body;

- (void) doAndIfSuccess:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success elseIfFailure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure;

@end
