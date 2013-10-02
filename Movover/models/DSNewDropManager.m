//
//  DSNewDropManager.m
//  Movover
//
//  Created by @leonardfactory on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSNewDropManager.h"
#import "DSDropSerializer.h"
#import "DSAppDelegate.h"

@implementation DSNewDropManager

@synthesize drop = _drop;

- (DSEntityManager *) init
{
	self = [super init];
	if (self)
	{
		[self setWebApiAdapter: [[DSWebApiAdapter alloc] init]];
	}
	return self;
}

- (void) captureWithImage:(UIImage *)image WithText:(NSString *) text
{
	[(DSAppDelegate *)[UIApplication sharedApplication].delegate registerWaitingForGeoFunction:^(NSString *lng, NSString *lat){
		NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:@"capture", @"type", lng, @"lng", lat, @"lat", text, @"text",nil];
		[self.webApiAdapter postPath:@"/drop" parameters:body success:^(NSDictionary *responseObject)
		 {
			 DSDropSerializer *ds = [[DSDropSerializer alloc] init];
			 _drop = [ds deserializeDropFrom:responseObject];
			 NSLog(@"drop added");
			 NSString *path = [NSString stringWithFormat:@"/drop/%@/image",_drop.identifier];
			 [self.webApiAdapter postImage:image toPath:path withName:@"image" success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
				 NSLog(@"Image added");
			 } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
				 NSLog(@"Failed to add image");
			 }];
		 } failure:^(NSString *responseError, int statusCode, NSError *error)
		 {
			 NSLog(@"%d",statusCode);
			 NSLog(@"%@",responseError);
		 }];
	}];
}

- (void) memoWithText:(NSString *) text
{
	[(DSAppDelegate *)[UIApplication sharedApplication].delegate registerWaitingForGeoFunction:^(NSString *lng, NSString *lat){
		NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:@"memo", @"type", lng, @"lng", lat, @"lat", text, @"text",nil];
		[self.webApiAdapter postPath:@"/drop" parameters:body success:^(NSDictionary *responseObject)
		 {
			 DSDropSerializer *ds = [[DSDropSerializer alloc] init];
			 _drop = [ds deserializeDropFrom:responseObject];
			 NSLog(@"Added: %@",_drop);
			 
		 } failure:^(NSString *responseError, int statusCode, NSError *error)
		 {
			 NSLog(@"%d",statusCode);
			 NSLog(@"%@",responseError);
		 }];
	}];
}

@end
