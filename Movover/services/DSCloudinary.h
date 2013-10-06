//
//  DSCloudinary.h
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cloudinary/Cloudinary.h>

@interface DSCloudinary : NSObject

@property (strong, nonatomic) CLCloudinary *cloudinary;

+ (id) sharedInstance;

@end
