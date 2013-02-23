//
//  DSServerRequest.m
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSServerRequest.h"
#define SERVERURL @"http://192.168.0.102"

@implementation DSServerRequest

- (DSServerRequest *) initWithMethod:(NSString *)method withEntity:(NSString *)entity withIdentifier:(NSString *)identifier withParams:(NSDictionary *)params withBody:(NSDictionary *)body
{
	NSString * serverUrl = [NSString stringWithFormat:@"%s/%s", SERVERURL, entity];
	if(identifier)
	{
		serverUrl = [NSString stringWithFormat:@"%s/%s", serverUrl, identifier];
	}
	if (params) {
		BOOL first = TRUE;
		serverUrl = [NSString stringWithFormat:@"%s?", serverUrl];
		for (NSString* key in params) {
			if(first)
			{
				first = FALSE;
			}
			else
			{
				serverUrl = [NSString stringWithFormat:@"%s&", serverUrl];
			}
			id value = [params objectForKey:key];
			serverUrl = [NSString stringWithFormat:@"%s%s=%s", serverUrl, key, value];
		}
	}
	
	NSURL *url = [NSURL URLWithString:];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	
	[request setHTTPMethod:@"GET"];
	
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		
		self.dropId = [[JSON objectForKey:@"id"] integerValue];
		self.title = [JSON valueForKey:@"title"];
		self.text = [JSON valueForKey:@"text"];
		self.latitude = (NSNumber*)[JSON valueForKey:@"latitude"];
		self.longitude = (NSNumber*)[JSON valueForKey:@"longitude"];
		[self setLoaded:true];
		
		NSLog(@"Loaded Drop with id %d (Title: %@)", self.dropId, self.title);
		
	} failure:nil];
}

- (void) doAndIfSuccess:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success elseIfFailure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
	
}

@end
