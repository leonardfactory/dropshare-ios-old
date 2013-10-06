//
//  DSJournalManager.h
//  Movover
//
//  Created by @leonardfactory on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSEntityManager.h"
#import "DSTokenManager.h"
#import "DSJournal.h"

@interface DSJournalManager : DSEntityManager

@property BOOL isJournalUpdated;
@property BOOL isJournalScrolled;
@property (strong, nonatomic) DSJournal *journal;

- (void) pullToRefresh;

- (void) scrollDown;

@end
