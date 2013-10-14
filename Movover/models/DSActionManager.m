//
//  DSActionManager.m
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSActionManager.h"
#import "DSActionSerializer.h"
#import "DSAppDelegate.h"

#import "DSCloudinary.h"

#import <ISO8601DateFormatter.h>

@implementation DSActionManager

@synthesize action = _action;

+ (instancetype) sharedManager
{
    static DSActionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[[self class] alloc] init];
    });
    return _sharedManager;
}

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

- (DSAction *) actionWithId:(NSString *)identifier
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(identifier = %@)", identifier];
    return (DSAction *)[self.dataAdapter findOneEntity:@"Action" withPredicate:predicate];
}

- (DSAction *) updateAndRetrieveActionWithId:(NSString *)identifier
{
    DSAction *action = [self actionWithId:identifier];
    
    __weak __block DSAction *futureAction = action;
    
    if(!action.subjectId)
    {
        [self.APIAdapter requestWithMethod:@"GET"
                                      path:[NSString stringWithFormat:@"/action/%@", identifier]
                                parameters:nil
                                   success:^(NSDictionary *responseObject)
        {
            DSActionSerializer *serializer = [[DSActionSerializer alloc] init];
            futureAction = [serializer deserializeActionFrom:responseObject];
            [self.dataAdapter save:nil];
        }
                                   failure:^(NSString *responseError, int statusCode, NSError *error)
        {
            NSLog(@"Error while getting Action.");
        }
                                     queue:identifier];
    }
    
    return action;
}

- (void) updateActionStatsWithId:(NSString *)identifier
{
    DSAction *action = [self actionWithId:identifier];
    
    [self.APIAdapter requestWithMethod:@"GET"
                                  path:[NSString stringWithFormat:@"/action/%@/stats", identifier]
                            parameters:nil
                               success:^(NSDictionary *responseObject)
    {
        [action setStatsLike:responseObject[@"stats"][@"like"]];
        [action setStatsComment:responseObject[@"stats"][@"comment"]];
        [action setStatsReaction:responseObject[@"stats"][@"reaction"]];
        
        [self.dataAdapter save:nil];
    }
                               failure:^(NSString *responseError, int statusCode, NSError *error)
    {
        NSLog(@"%d",statusCode);
        NSLog(@"%@",responseError);
    }
                                 queue:identifier];
}

- (void) likeActionWithId:(NSString *)identifier
{
    DSAction *action = [self actionWithId:identifier];
    [self likeAction:action];
}

- (void) likeAction:(DSAction *)action
{
    [action setStatsLike:[NSNumber numberWithInt:([action.statsLike intValue] + 1)]];
    [action setLike:[NSNumber numberWithBool:YES]];
    [self.dataAdapter save:nil];
    NSLog(@"Actually we saved stats like to: %@", action.statsLike);
    
    [self.APIAdapter requestWithMethod:@"POST"
                                  path:[NSString stringWithFormat:@"/action/%@/like", action.identifier]
                            parameters:nil
                               success:^(NSDictionary *responseObject)
     {
         // Ok!
     }
                               failure:^(NSString *responseError, int statusCode, NSError *error)
     {
         NSLog(@"%d",statusCode);
         NSLog(@"%@",responseError);
     }
                                 queue:action.identifier];
}

- (void) unlikeActionWithId:(NSString *)identifier
{
    DSAction *action = [self actionWithId:identifier];
    [self unlikeAction:action];
}

- (void) unlikeAction:(DSAction *)action
{
    [action setStatsLike:[NSNumber numberWithInt:([action.statsLike intValue] - 1)]];
    [action setLike:[NSNumber numberWithBool:NO]];
    [self.dataAdapter save:nil];
    NSLog(@"Actually we saved stats like to: %@", action.statsLike);
    
    [self.APIAdapter requestWithMethod:@"DELETE" path:[NSString stringWithFormat:@"/action/%@/like", action.identifier]
                            parameters:nil
                               success:^(NSDictionary *responseObject)
     {
         // Ok!
     }
                               failure:^(NSString *responseError, int statusCode, NSError *error)
     {
         NSLog(@"%d",statusCode);
         NSLog(@"%@",responseError);
     }
                                 queue:action.identifier];
}
@end
