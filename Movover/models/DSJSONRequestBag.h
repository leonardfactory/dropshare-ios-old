//
//  DSJSONRequestBag.h
//  Movover
//
//  Created by Leonardo on 14/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSJSONRequestBag : NSObject

@property (strong, nonatomic) NSString *method;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSDictionary *parameters;
@property (strong, nonatomic) void (^success)(NSDictionary *);
@property (strong, nonatomic) void (^failure)(NSString *, int, NSError *);

- (DSJSONRequestBag *) initWithMethod:(NSString *)method
                                 path:(NSString *)path
                           parameters:(NSDictionary *)parameters
                              success:(void (^)(NSDictionary *))success
                              failure:(void (^)(NSString *, int, NSError *))failure;

@end
