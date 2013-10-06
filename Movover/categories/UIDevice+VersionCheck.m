//
//  UIDevice+VersionCheck.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "UIDevice+VersionCheck.h"

@implementation UIDevice (VersionCheck)

- (NSUInteger) systemMajorVersion
{
    NSString * versionString;
    versionString = [ self systemVersion ];
    return ( NSUInteger )[ versionString doubleValue ];
}

@end
