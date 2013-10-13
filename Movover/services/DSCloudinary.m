//
//  DSCloudinary.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSCloudinary.h"
#import "math.h"

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

+ (CLTransformation *) transformationWithWidth:(float) width andHeight:(float) height
{
    CLTransformation *transformation = [CLTransformation transformation];
    
    float scale = [[UIScreen mainScreen] scale];
    
    int intWidth = round(scale * width);
    int intHeight = round(scale * height);
    
    [transformation setWidthWithInt:intWidth];
    [transformation setHeightWithInt:intHeight];
    
    return transformation;
}

@end
