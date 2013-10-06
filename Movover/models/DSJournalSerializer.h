//
//  DSJournalSerializer.h
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSSerializer.h"
#import "DSJournal.h"

typedef enum {
    DSJournalInsertAtBeginning,
    DSJournalInsertAtEnd
} DSJournalInsertAt;

@interface DSJournalSerializer : DSSerializer

- (DSJournal *) deserializeJournalFrom:(NSDictionary *)representation andInsertAt:(DSJournalInsertAt) insertAt;

@end
