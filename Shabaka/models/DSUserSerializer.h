//
//  DSUserSerializer.h
//  Shabaka
//
//  Created by Francesco on 13/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSDataAdapter.h"

@interface DSUserSerializer : NSObject

@property (strong, nonatomic) DSDataAdapter *dataAdapter;

- (User *) deserializeUserFrom:(NSDictionary *) dict;

@end
