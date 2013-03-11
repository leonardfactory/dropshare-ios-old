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

@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImageView *mainBackgroundImageView;

+ (CGFloat) heightForCellWithText:(NSString *)text;

- (void) setAvatarImage:(UIImage *)image;
- (void) recalculateSizes;
- (void) shiftContent:(CGFloat)deltaY;

@end
