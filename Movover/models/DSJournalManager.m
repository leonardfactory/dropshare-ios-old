//
//  DSJournalManager.m
//  Movover
//
//  Created by @leonardfactory on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSJournalManager.h"
#import "DSJournalSerializer.h"

#import "DSJournal.h"
#import "DSActivity.h"

#define DROPCOUNT (@5)

@interface DSJournalManager (){}

@property (strong, nonatomic) DSTokenManager *tokenManager;
@property (strong, nonatomic) NSString *identifier;

@property (strong, nonatomic) DSJournal *journal;

@end

@implementation DSJournalManager

- (DSEntityManager *) init
{
	self = [super init];
	if (self)
	{
		[self setJournal:[[self dataAdapter] findOrCreate:@"Journal" onModel:@"Journal" error:nil]];
		
		//get id of the user logged
		_tokenManager = [[DSTokenManager alloc] init];
		_identifier = _tokenManager.token.user.identifier;
		assert(_identifier);
		
		//_activitiesInTheMiddle = [[NSMutableOrderedSet alloc] init];
		//_activities            = [[NSMutableOrderedSet alloc] init];
		
		//init dropsInTheMiddle e actual drops with the content of journal.drop
		/*for (DSActivity *activity in _journal.activities)
        {
			[_activities addObject:activity];
		}*/
		
		[self setAPIAdapter:[DSAPIAdapter sharedAPIAdapter]];
	}
	return self;
}

- (void) pullToRefresh
{
	// _activitiesInTheMiddle = [_activities copy];
	DSActivity *since_activity = [_journal.activities firstObject];
    
	NSDictionary *body;
	if(since_activity)
	{
        body = @{
                 @"limit" : @10,
                 @"since" : since_activity.objectID
                 };
	}
	else
	{
		body = @{ @"limit" : @10 };
	}
    
	[self.APIAdapter getPath:@"/user/journal" parameters:body success:^(NSDictionary *responseObject)
	{
        DSJournalSerializer *serializer = [[DSJournalSerializer alloc] init];
        _journal = [serializer deserializeJournalFrom:responseObject];
		
		self.isJournalUpdated = TRUE;
	} failure:^(NSString *responseError, int statusCode, NSError *error)
	{
		NSLog(@"%d",statusCode);
		NSLog(@"%@",responseError);
	}];
}

- (void) scrollDown
{
	DSActivity *last_activity = [_journal.activities lastObject];
	NSDictionary *body;

    body = @{
             @"limit": @20,
             @"until": last_activity.objectID
             };

	[self.APIAdapter getPath:@"/user/journal" parameters:body success:^(NSDictionary *responseObject)
	{
		DSJournalSerializer *serializer = [[DSJournalSerializer alloc] init];
		_journal = [serializer deserializeJournalFrom:responseObject];
        
		self.isJournalScrolled = TRUE;
	} failure:^(NSString *responseError, int statusCode, NSError *error)
	{
		NSLog(@"%d",statusCode);
		NSLog(@"%@",responseError);
	}];
}

@end
