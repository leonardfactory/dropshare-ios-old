//
//  DSJournalManager.h
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSEntityManager.h"
#import "DSProfileManager.h"

@interface DSJournalManager : DSEntityManager

@property BOOL isJournalUpdated;
@property BOOL isJournalScrolled;
@property (strong, nonatomic) NSMutableOrderedSet *drops;
@property (nonatomic, retain) NSMutableOrderedSet *dropsInTheMiddle;

- (void) pullToRefresh;

- (void) scrollDown;

@end
