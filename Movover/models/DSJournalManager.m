//
//  DSJournalManager.m
//  Movover
//
//  Created by @leonardfactory on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSJournalManager.h"
#import "DSJournalSerializer.h"

#import "DSActivitySerializer.h"
#import "DSActivity.h"

#define DROPCOUNT (@5)

@interface DSJournalManager (){}

@property (strong, nonatomic) DSTokenManager *tokenManager;
@property (strong, nonatomic) NSString *identifier;

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
		//assert(_identifier);
		
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
                 @"since" : since_activity.identifier
                 };
	}
	else
	{
		body = @{ @"limit" : @10 };
	}
    
	[self.APIAdapter getPath:@"/user/journal" parameters:body success:^(NSDictionary *responseObject)
	{
        NSString *lastIdentifier = [[responseObject[@"activity"] lastObject] valueForKey:@"_id"];
        NSMutableDictionary *responseFixed = [responseObject mutableCopy];
        
        // Se l'ultimo elemento della lista non è uguale al mio, vuol dire che c'è un gap. Dunque invalido la cache
        if(![lastIdentifier isEqualToString:since_activity.identifier]) {
            [self invalidateCache];
        }
        // Altrimenti elimino l'ultimo elemento (non c'è bisogno di reinserirlo)
        else {
            NSMutableArray *activityWithLastRemoved = [responseObject[@"activity"] mutableCopy];
            [activityWithLastRemoved removeLastObject];
            
            responseFixed[@"activity"] = activityWithLastRemoved;
        }
        
        DSJournalSerializer *serializer = [[DSJournalSerializer alloc] init];
        _journal = [serializer deserializeJournalFrom:responseFixed andInsertAt:DSJournalInsertAtBeginning];
		
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
             @"limit": @10,
             @"until": last_activity.identifier
             };

	[self.APIAdapter getPath:@"/user/journal" parameters:body success:^(NSDictionary *responseObject)
	{
		DSJournalSerializer *serializer = [[DSJournalSerializer alloc] init];
		_journal = [serializer deserializeJournalFrom:responseObject andInsertAt:DSJournalInsertAtEnd];
        
		self.isJournalScrolled = TRUE;
	} failure:^(NSString *responseError, int statusCode, NSError *error)
	{
		NSLog(@"%d",statusCode);
		NSLog(@"%@",responseError);
	}];
}

- (void) invalidateCache
{
    for(DSActivity *activity in _journal.activities) {
        [self.dataAdapter remove:activity error:nil];
    }
    _journal.activities = [NSOrderedSet orderedSet];
    [self.dataAdapter save:nil];
}

@end
