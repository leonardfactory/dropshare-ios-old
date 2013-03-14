//
//  DSJournalManager.m
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSJournalManager.h"
#import "DSDropSerializer.h"

#define DROPCOUNT (@5)

@interface DSJournalManager (){}

@property (strong, nonatomic) DSProfileManager *profileManager;
@property (strong, nonatomic) NSString *identifier;

@property (strong, nonatomic) DropCollection *journal;

@end

@implementation DSJournalManager

- (DSEntityManager *) init
{
	self = [super init];
	if (self)
	{
		[self setJournal:[[self dataAdapter] findOrCreate:@"journal" onModel:@"DropCollection" error:nil]];
		
		//get id of the user logged
		_profileManager = [[DSProfileManager alloc] init];
		_identifier = _profileManager.profile.user.identifier;
		assert(_identifier);
		
		_dropsInTheMiddle = [[NSMutableOrderedSet alloc] init];
		_drops = [[NSMutableOrderedSet alloc] init];
		
		//init dropsInTheMiddle e actual drops with the content of journal.drop
		for (Drop *drop in _journal.drops) {
			[_drops addObject:drop];
		}
		
		[self setWebApiAdapter: [[DSWebApiAdapter alloc] init]];
	}
	return self;
}

- (void) pullToRefresh
{
	_dropsInTheMiddle = [_drops copy];
	Drop *since_drop = [_dropsInTheMiddle firstObject];
	NSString *path = [NSString stringWithFormat:@"/user/%@/journal",_identifier];
	NSDictionary *body;
	if(since_drop)
	{
		body = [NSDictionary dictionaryWithObjectsAndKeys:DROPCOUNT, @"count", since_drop.createdOnString, @"since_date",nil];
	}
	else
	{
		body = [NSDictionary dictionaryWithObjectsAndKeys:DROPCOUNT, @"count",nil];
	}
	[self.webApiAdapter getPath:path parameters:body success:^(NSDictionary *responseObject)
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
	Drop *max_drop = [_drops lastObject];
	assert(max_drop);
	Drop *since_drop = [_dropsInTheMiddle firstObject];
	NSString *path = [NSString stringWithFormat:@"/user/%@/journal",_identifier];
	NSDictionary *body;
	if(since_drop)
	{
		body = [NSDictionary dictionaryWithObjectsAndKeys:DROPCOUNT, @"count", since_drop.createdOnString, @"since_date", max_drop.createdOnString, @"max_date", nil];
	}
	else
	{
		body = [NSDictionary dictionaryWithObjectsAndKeys:DROPCOUNT, @"count", max_drop.createdOnString, @"max_date", nil];
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
