//
//  DSEntityManager.h
//  Model
//
//  Created by @leonardfactory on 25/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSDataAdapter.h"
#import "DSWebApiAdapter.h"

@interface DSEntityManager : NSObject

@property (strong, nonatomic) DSDataAdapter *dataAdapter;
@property (strong, nonatomic) DSWebApiAdapter *webApiAdapter;

@end
