//
//  DSCloudinary.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSCloudinary.h"

@implementation DSCloudinary

@synthesize cloudinary = _cloudinary;

+ (id) sharedInstance
{
    static DSCloudinary *_sharedCloudinary = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCloudinary = [[self alloc] init];
    });
    
    return _sharedCloudinary;
}

- (DSCloudinary *) init
{
    self = [super init];
    if(self)
    {
        _cloudinary = [[CLCloudinary alloc] init];
        [_cloudinary.config setValue:@"hysf85emt" forKey:@"cloud_name"];
    }
    return self;
}

@end
