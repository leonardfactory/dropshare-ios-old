//
//  DSActionManager.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSActionManager.h"
#import "DSAppDelegate.h"

#import "DSCloudinary.h"

#import <ISO8601DateFormatter.h>

@implementation DSActionManager

@synthesize action = _action;

- (void) captureWithImage:(UIImage *)image andText:(NSString *) text
{
    [(DSAppDelegate *)[UIApplication sharedApplication].delegate registerWaitingForGeoFunction:^(NSString *lng, NSString *lat){
        NSDictionary *body = @{
                               @"type" : @"capture",
                               @"position" : @{
                                       @"lat" : [NSNumber numberWithDouble:[lat doubleValue]],
                                       @"lon" : [NSNumber numberWithDouble:[lng doubleValue]]
                                       },
                               @"text" : text
                               };
        
        [self.APIAdapter postPath:@"/action" parameters:body success:^(NSDictionary *responseObject) {
            
            NSString *identifier = responseObject[@"_id"];
            
            // Post image
            [self.APIAdapter getPath:[NSString stringWithFormat:@"/action/%@/signature", identifier] parameters:nil success:^(NSDictionary *responseObject) {
                
                CLUploader *uploader = [[CLUploader alloc] init:[[DSCloudinary sharedInstance] cloudinary] delegate:self];
                [uploader upload:UIImageJPEGRepresentation(image, 0.8) options:responseObject withCompletion:^(NSDictionary *successResult, NSString *errorResult, NSInteger code, id context) {
                    NSLog(@"Upload done");
                } andProgress:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite, id context) {
                    // nothing
                }];
                
            } failure:^(NSString *responseError, int statusCode, NSError *error) {
                NSLog(@"%d",statusCode);
                NSLog(@"%@",responseError);
            }];
            
        } failure:^(NSString *responseError, int statusCode, NSError *error) {
            NSLog(@"%d",statusCode);
            NSLog(@"%@",responseError);
        }];
    }];
}

@end
