//
//  DSAPIClient.h
//  Movover
//
//  Created by Leonardo on 04/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <AFRESTClient.h>
#import <AFIncrementalStore.h>

@interface DSAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (DSAPIClient *) sharedClient;

@end
