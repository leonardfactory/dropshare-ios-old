//
//  DSJournalCell.m
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSJournalCell.h"

#define kDSUsernameFontSize 18.0
#define kDSDescriptionFontSize 16.0

#define kDSAvatarRoundedCornersSize 4.0
#define kDSAvatarShadowSize 2.0

@interface DSJournalCell ()

@end

@implementation DSJournalCell

+ (CGFloat) heightForCellWithText:(NSString *)text
{
	CGFloat textLabelHeight = [text sizeWithFont:[UIFont systemFontOfSize:kDSDescriptionFontSize]
							   constrainedToSize:CGSizeMake(236.0, FLT_MAX)
								   lineBreakMode:UILineBreakModeWordWrap].height;
	
	return  textLabelHeight + 50.0;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		self.frame = CGRectMake(0.0, 0.0, 320.0, 80.0);
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
		self.mainBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4.0, 4.0, 312.0, 76.0)];
		[self.mainBackgroundImageView setImage:[[UIImage imageNamed:@"mainBgTile.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6.0, 8.0, 10.0, 8.0)]];
		self.mainBackgroundImageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		[self addSubview:self.mainBackgroundImageView];
		
		self.avatarImageView		= [[UIImageView alloc] initWithFrame:CGRectMake(14.0, 14.0, 48.0, 48.0)];
		[self addSubview:self.avatarImageView];
		
		self.usernameLabel					= [[UILabel alloc] initWithFrame:CGRectMake(70.0, 14.0, 120.0, 20.0)];
		self.usernameLabel.backgroundColor	= [UIColor whiteColor]; // +speed
		self.usernameLabel.font				= [UIFont systemFontOfSize:kDSUsernameFontSize];
		self.usernameLabel.text				= @"Username";
		[self addSubview:self.usernameLabel];
		
		self.descriptionLabel					= [[UILabel alloc] initWithFrame:CGRectMake(70.0, 34.0, 236.0, 20.0)];
		self.descriptionLabel.backgroundColor	= [UIColor whiteColor];
		self.descriptionLabel.font				= [UIFont systemFontOfSize:kDSDescriptionFontSize];
		self.descriptionLabel.lineBreakMode		= NSLineBreakByWordWrapping;
		self.descriptionLabel.numberOfLines		= 0; // Automatically \n
		self.descriptionLabel.text				= @"Description text";
		[self addSubview:self.descriptionLabel];
		
    }
    return self;
}

- (void) recalculateSizes
{
	CGRect descriptionLabelFrame = self.descriptionLabel.frame;
	
	float descriptionLabelHeight = [self.descriptionLabel.text sizeWithFont:[UIFont systemFontOfSize:16.0f]
														  constrainedToSize:CGSizeMake(236.0, FLT_MAX)
															  lineBreakMode:UILineBreakModeWordWrap].height;
	
	self.descriptionLabel.frame = CGRectMake(descriptionLabelFrame.origin.x,
											 descriptionLabelFrame.origin.y,
											 descriptionLabelFrame.size.width,
											 descriptionLabelHeight);
	
//	NSLog(@"| [Current JournalCell: %@",	self.usernameLabel.text);
//	NSLog(@"| mainBackground Frame %@",		NSStringFromCGRect(self.mainBackgroundImageView.frame));
//	NSLog(@"| Main frame: %@ | Bounds: %@", NSStringFromCGRect(self.frame), NSStringFromCGRect(self.bounds));
//	NSLog(@"| Username label Frame: %@",	NSStringFromCGRect(self.usernameLabel.frame));
}

#pragma mark - Move content to insert other things over text, user & description
- (void) shiftContent:(CGFloat) deltaY
{
	self.avatarImageView.frame	= CGRectOffset(self.avatarImageView.frame, 0.0, deltaY);
	self.usernameLabel.frame	= CGRectOffset(self.usernameLabel.frame, 0.0, deltaY);
	self.descriptionLabel.frame	= CGRectOffset(self.descriptionLabel.frame, 0.0, deltaY);
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
