//
//  DSJournalManager.m
//  Movover
//
//  Created by @leonardfactory on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSJournalManager.h"
#import "DSDropSerializer.h"

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
		
		_activitiesInTheMiddle = [[NSMutableOrderedSet alloc] init];
		_activities            = [[NSMutableOrderedSet alloc] init];
		
		//init dropsInTheMiddle e actual drops with the content of journal.drop
		for (DSActivity *activity in _journal.activities)
        {
			[_activities addObject:activity];
		}
		
		[self setAPIAdapter:[DSAPIAdapter sharedAPIAdapter]];
	}
	return self;
}

- (void) pullToRefresh
{
	_activitiesInTheMiddle = [_activities copy];
	DSActivity *since_activity = [_activitiesInTheMiddle firstObject];
    
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
		body = @{ @"limit" : @20 };
	}
    
	[self.APIAdapter getPath:@"/user/journal" parameters:body success:^(NSDictionary *responseObject)
	{
		DSDropSerializer *ds = [[DSDropSerializer alloc] init];
		[ds deserializeDropSetFrom:[responseObject objectForKey:@"journal"] intoDropCollection:_journal];
		
		_drops = [[NSMutableOrderedSet alloc] init];
		for (Drop *drop in _journal.drops) {
			[_drops addObject:drop];
		}
		
		if(_journal.drops.count < [DROPCOUNT integerValue])
		{
			for (Drop *drop in _dropsInTheMiddle) {
				[_drops addObject:drop];
				[_journal addDropsObject:drop];
			}
			
			[self.dataAdapter save:nil];
			_dropsInTheMiddle = [[NSMutableOrderedSet alloc] init];
		}
		
		self.isJournalUpdated = TRUE;
	} failure:^(NSString *responseError, int statusCode, NSError *error)
	{
		NSLog(@"%d",statusCode);
		NSLog(@"%@",responseError);
	}];
}

- (void) scrollDown
{
	DSAction *max_drop = [_drops lastObject];
	assert(max_drop);
	Drop *since_drop = [_dropsInTheMiddle firstObject];
	NSString *path = [NSString stringWithFormat:@"/user/%@/journal",_identifier];
	NSDictionary *body;
	if(since_drop)
	{
		body = [NSDictionary dictionaryWithObjectsAndKeys:DROPCOUNT, @"count", since_drop.stringCreatedOn, @"since_date", max_drop.stringCreatedOn, @"max_date", nil];
	}
	else
	{
		body = [NSDictionary dictionaryWithObjectsAndKeys:DROPCOUNT, @"count", max_drop.stringCreatedOn, @"max_date", nil];
	}
	[self.webApiAdapter getPath:path parameters:body success:^(NSDictionary *responseObject)
	{
		DSDropSerializer *ds = [[DSDropSerializer alloc] init];
		int count = [ds deserializeDropSetFrom:[responseObject objectForKey:@"journal"] appendIntoDropCollection:_journal];
		
		_drops = [[NSMutableOrderedSet alloc] init];
		for (Drop *drop in _journal.drops) {
			[_drops addObject:drop];
		}
		
		if(count < [DROPCOUNT integerValue])
		{
			for (Drop *drop in _dropsInTheMiddle) {
				[_drops addObject:drop];
				[_journal addDropsObject:drop];
			}
			
			[self.dataAdapter save:nil];
			_dropsInTheMiddle = [[NSMutableOrderedSet alloc] init];
		}
		
		self.isJournalScrolled = TRUE;
	} failure:^(NSString *responseError, int statusCode, NSError *error)
	{
		NSLog(@"%d",statusCode);
		NSLog(@"%@",responseError);
	}];
}

@end
