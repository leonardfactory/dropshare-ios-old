//
//  DSJournalSimpleDropCell.h
//  Movover
//
//  Created by Leonardo Ascione on 24/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSJournalSimpleDropCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
