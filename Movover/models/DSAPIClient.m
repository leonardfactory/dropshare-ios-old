//
//  DSAPIClient.m
//  Movover
//
//  Created by Leonardo on 04/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSAPIClient.h"
#import "DSFetchRequest.h"

#import <ISO8601DateFormatter.h>

static NSString * const kDSAPIBaseURLString = @"http://api.movover.com/";

@implementation DSAPIClient

+ (DSAPIClient *)sharedClient
{
    static DSAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kDSAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

#pragma mark - AFIncrementalStore

/**
 * Define API getters to fetch entities
 */
- (NSURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                             withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *mutableURLRequest = nil;
    NSDictionary *parameters = nil;
    
    if ([fetchRequest isKindOfClass:[DSFetchRequest class]]) {
        parameters = [(DSFetchRequest *)fetchRequest parameters];
    }
    
    if ([fetchRequest.entityName isEqualToString:@"Journal"]) {
        mutableURLRequest = [self requestWithMethod:@"GET" path:@"user/journal" parameters:parameters];
    }
    
    return mutableURLRequest;
}

/**
 * Are we talking about arrays or single entities? Return the right one!
 */

- (id)representationOrArrayOfRepresentationsOfEntity:(NSEntityDescription *)entity
                                  fromResponseObject:(id)responseObject
{
    id representation = @[];
    
    if([entity.name isEqualToString:@"Journal"]) {
        // refer to https://github.com/leonardfactory/movover-server/wiki/get_user_journal#json-response
        representation = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        representation[@"id"] = @"Journal";
    }
    
    return representation;
}

/**
 * Get relationships
 */
- (NSDictionary *)representationsForRelationshipsFromRepresentation:(NSDictionary *)representation
                                                           ofEntity:(NSEntityDescription *)entity
                                                       fromResponse:(NSHTTPURLResponse *)response
{
    if([entity.name isEqualToString:@"Journal"]) {
        NSMutableDictionary *mutableRelationshipRepresentations = [NSMutableDictionary dictionaryWithCapacity:[entity.relationshipsByName count]];
        [mutableRelationshipRepresentations setValue:[representation valueForKey:@"activity"] forKey:@"activities"];
        return mutableRelationshipRepresentations;
    }
    else {
        return [super representationsForRelationshipsFromRepresentation:representation ofEntity:entity fromResponse:response];
    }
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    ISO8601DateFormatter *dateFormatter = [[ISO8601DateFormatter alloc] init];
    
    if ([entity.name isEqualToString:@"Journal"]) {
        //[mutablePropertyValues setValue:@"Journal" forKey:@"id"];
        [mutablePropertyValues setValue:[NSDate date] forKey:@"updatedOn"];
    }
    else if ([entity.name isEqualToString:@"Activity"]) {
        
        NSString *subjectRef = (NSString *)[representation valueForKeyPath:@"subject.ref"];
        
        if([subjectRef isEqualToString:@"user"]) {
            [mutablePropertyValues setValue:@"User" forKey:@"subjectEntity"];
        }
        else if([subjectRef isEqualToString:@"area"]) {
            [mutablePropertyValues setValue:@"Area" forKey:@"subjectEntity"];
        }
        
        [mutablePropertyValues setValue:[representation valueForKeyPath:@"subject._id"] forKey:@"subjectId"];
        
        // How to handle user data got here?
        // @here
    }
    
    return mutablePropertyValues;
}


@end
