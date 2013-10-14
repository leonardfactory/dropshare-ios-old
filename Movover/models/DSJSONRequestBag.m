//
//  DSJSONRequestBag.m
//  Movover
//
//  Created by Leonardo on 14/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSJSONRequestBag.h"

@implementation DSJSONRequestBag

- (DSJSONRequestBag *) initWithMethod:(NSString *)method
                                 path:(NSString *)path
                           parameters:(NSDictionary *)parameters
                              success:(void (^)(NSDictionary *))success
                              failure:(void (^)(NSString *, int, NSError *))failure
{
    self = [super init];
    if(self)
    {
        [self setMethod:method];
        [self setPath:path];
        [self setParameters:parameters];
        [self setSuccess:success];
        [self setFailure:failure];
    }
    return self;
}

@end
