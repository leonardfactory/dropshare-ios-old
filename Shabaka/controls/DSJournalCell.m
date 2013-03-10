//
//  DSJournalCell.m
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSJournalCell.h"

#define DS_AVATAR_ROUNDED_CORNERS 4.0
#define DS_AVATAR_SHADOW_SIZE 2.0

@interface DSJournalCell ()

@end

@implementation DSJournalCell

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
       
    }
    return self;
}

- (void) recalculateBackgroundSize
{
	CGRect mainBackgroundImageFrame = self.mainBackgroundImageView.frame;
	CGRect descriptionLabelFrame = self.descriptionLabel.frame;
	
	float descriptionLabelHeight = [self.descriptionLabel.text sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(236.0, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap].height;
	
	
	/*self.mainBackgroundImageView.frame = CGRectMake(mainBackgroundImageFrame.origin.x,
													mainBackgroundImageFrame.origin.y,
													mainBackgroundImageFrame.size.width,
													descriptionLabelHeight + 50.0);*/
	
	self.descriptionLabel.frame = CGRectMake(descriptionLabelFrame.origin.x,
											 descriptionLabelFrame.origin.y,
											 descriptionLabelFrame.size.width,
											 descriptionLabelHeight);
	
	NSLog(@"| [Current JournalCell: %@", self.usernameLabel.text);
	NSLog(@"| mainBackground Frame %@", NSStringFromCGRect(self.mainBackgroundImageView.frame));
	NSLog(@"| Main frame: %@ | Bounds: %@", NSStringFromCGRect(self.frame), NSStringFromCGRect(self.bounds));
	NSLog(@"| Username label Frame: %@", NSStringFromCGRect(self.usernameLabel.frame));
}

- (void) setAvatarImage:(UIImage *)image
{
	[self.avatarImageView setImage:image];
	
	//[self.imageView.layer setCornerRadius:DS_AVATAR_ROUNDED_CORNERS];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
