//
//  DSJournalCell.h
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DSJournalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainBackgroundImageView;

- (void) setAvatarImage:(UIImage *)image;
- (void) recalculateSizes;

@end
