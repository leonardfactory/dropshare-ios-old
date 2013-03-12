//
//  DSJournalTableViewController.h
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSJournalCell.h"
#import "DSImageJournalCell.h"

@interface DSJournalTableViewController : UITableViewController

// Just for testing
@property (strong, nonatomic) NSMutableArray *cellData;
@property (strong, nonatomic) NSMutableArray *textData;
@property (strong, nonatomic) NSMutableArray *imageData;

@end
