//
//  DSImageUrl.m
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSImageUrl.h"

@implementation DSImageUrl

+ (NSString *) getAvatarUrlFromUserId:(NSString *) identifier
{
	assert(identifier);
	return [NSString stringWithFormat:@"%@/user/%@/avatar/96.jpg",[DSImageUrl url],identifier];
}

+ (NSString *) getImageUrlFromDropId: (NSString *) identifier
{
	assert(identifier);
	return [NSString stringWithFormat:@"%@/drop/%@/image/584x584.jpg",[DSImageUrl url],identifier];
}

+ (NSString *) url
{
	return @"http://ec2-54-228-232-120.eu-west-1.compute.amazonaws.com";
}

@end
