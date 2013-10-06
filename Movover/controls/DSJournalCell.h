//
//  DSJournalCell.h
//  Movover
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DSJournalCell : UITableViewCell

@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImageView *shadowAvatarImageView;
@property (strong, nonatomic) UIView *mainBackgroundView;

@property (strong, nonatomic) UIView *infoLabels;
@property (strong, nonatomic) UIImageView *separatorImageView;
@property (strong, nonatomic) UIImageView *geoLocationImageView;
@property (strong, nonatomic) UIImageView *timeImageView;
@property (strong, nonatomic) UILabel *geoLocationLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIView *socialButtons;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *commentButton;

+ (CGFloat) heightForCellWithText:(NSString *)text;

- (void) setAvatarWithURL:(NSURL *) imageURL;
- (void) setAvatarImage:(UIImage *)image;
- (void) recalculateSizes;
- (void) shiftContent:(CGFloat)deltaY;
- (void) setGeoLocation:(NSString *)geoLocation andTime:(NSString *)time;

@end
