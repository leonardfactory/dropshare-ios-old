//
//  DSJournalCell.m
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DSJournalCell.h"
#import "InterfaceConstants.h"

@interface DSJournalCell ()

@end

@implementation DSJournalCell

+ (CGFloat) heightForCellWithText:(NSString *)text
{
	CGFloat textLabelHeight = [text sizeWithFont:[UIFont systemFontOfSize:kDSCellDescriptionFontSize]
							   constrainedToSize:CGSizeMake(kDSCellDescriptionWidth, FLT_MAX)
								   lineBreakMode:UILineBreakModeWordWrap].height;
	
	return  textLabelHeight + kDSCellHeight - kDSCellDescriptionHeight;
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
		// Per ogni elemento della view aggiunto, bisogna aggiungere il CGRectOffset per spostarlo in shiftContent
		// @todo Aggiungere weakReferences
		self.frame				= CGRectMake(0.0, 0.0, kDSCellWidth, kDSCellHeight);
		self.backgroundColor	= [UIColor clearColor];
		self.autoresizingMask	= (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
		self.mainBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDSCellBackgroundMargin, kDSCellBackgroundMargin, kDSCellBackgroundWidth, kDSCellBackgroundHeight)];
		[self.mainBackgroundImageView setImage:[[UIImage imageNamed:@"mainBgTile.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6.0, 8.0, 10.0, 8.0)]];
		self.mainBackgroundImageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		[self addSubview:self.mainBackgroundImageView];
		
		// Avatar frame e inner shadow
		self.avatarImageView						= [[UIImageView alloc] initWithFrame:CGRectMake(kDSCellAvatarLeftMargin, kDSCellAvatarTopMargin, kDSCellAvatarSize, kDSCellAvatarSize)];
		self.avatarImageView.layer.cornerRadius		= kDSCellAvatarCornerRadius;
		self.avatarImageView.layer.masksToBounds	= YES;
		[self addSubview:self.avatarImageView];
		
		self.shadowAvatarImageView			= [[UIImageView alloc] initWithFrame:self.avatarImageView.frame];
		self.shadowAvatarImageView.image	= [[UIImage imageNamed:@"innerShadow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
		self.shadowAvatarImageView.alpha	= kDSCellInnerShadowAlpha;
		[self addSubview:self.shadowAvatarImageView];
		
		self.usernameLabel					= [[UILabel alloc] initWithFrame:CGRectMake(kDSCellLabelLeftMargin, kDSCellUsernameTopMargin, kDSCellUsernameWidth, kDSCellUsernameHeight)];
		self.usernameLabel.backgroundColor	= [UIColor whiteColor]; // +speed
		self.usernameLabel.font				= [UIFont boldSystemFontOfSize:kDSCellUsernameFontSize];
		self.usernameLabel.textColor		= [UIColor grayColor];
		self.usernameLabel.text				= @"Username";
		[self addSubview:self.usernameLabel];
		
		self.descriptionLabel					= [[UILabel alloc] initWithFrame:CGRectMake(kDSCellLabelLeftMargin, kDSCellDescriptionTopMargin, kDSCellDescriptionWidth, kDSCellDescriptionHeight)];
		self.descriptionLabel.backgroundColor	= [UIColor whiteColor];
		self.descriptionLabel.font				= [UIFont systemFontOfSize:kDSCellDescriptionFontSize];
		self.descriptionLabel.lineBreakMode		= NSLineBreakByWordWrapping;
		self.descriptionLabel.numberOfLines		= 0; // Automatically \n
		self.descriptionLabel.text				= @"Description text";
		[self addSubview:self.descriptionLabel];
		
		// Info on GeoLocation and Time
		UIFont *infoFont		= [UIFont systemFontOfSize:kDSDefaultSmallFontSize];
		UIColor *infoFontColor	= [UIColor lightGrayColor];
		
		self.infoLabels		= [[UIView alloc] initWithFrame:CGRectMake(kDSCellLabelLeftMargin,
																	   kDSCellDescriptionTopMargin + kDSCellDescriptionHeight + 4.0,
																	   kDSCellLabelWidth,
																	   14.0)];
		[self addSubview:self.infoLabels];
		
		self.geoLocationImageView		= [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 2.0, 10.0, 10.0)];
		self.geoLocationImageView.image = [UIImage imageNamed:@"geoLocationIcon.png"];
		[self.infoLabels addSubview:self.geoLocationImageView];
		
		self.geoLocationLabel			= [[UILabel alloc] initWithFrame:CGRectMake(10.0 + 2.0, 0.0, 100.0, 14.0)];
		self.geoLocationLabel.text		= @"Placeholder";
		self.geoLocationLabel.font		= infoFont;
		self.geoLocationLabel.textColor = infoFontColor;
		[self.infoLabels addSubview:self.geoLocationLabel];
		
		self.separatorImageView			= [[UIImageView alloc] initWithFrame:CGRectMake(114.0, 5.0, 2.0, 2.0)];
		self.separatorImageView.image	= [UIImage imageNamed:@"dotSeparator.png"];
		[self.infoLabels addSubview:self.separatorImageView];
		
		self.timeImageView			= [[UIImageView alloc] initWithFrame:CGRectMake(120.0, 1.0, 11.0, 11.0)];
		self.timeImageView.image	= [UIImage imageNamed:@"timeIcon.png"];
		[self.infoLabels addSubview:self.timeImageView];
		
		self.timeLabel				= [[UILabel alloc] initWithFrame:CGRectMake(133.0, 0.0, 100.0, 14.0)];
		self.timeLabel.text			= @"11/02/2012";
		self.timeLabel.font			= infoFont;
		self.timeLabel.textColor	= infoFontColor;
		[self.infoLabels addSubview:self.timeLabel];
		
		// Comments and Social buttons / indicators
		self.socialButtons	= [[UIView alloc] initWithFrame:CGRectMake(kDSCellLabelLeftMargin,
																	   self.infoLabels.frame.origin.y + self.infoLabels.frame.size.height + 4.0,
																	   kDSCellLabelWidth,
																	   33.0)];
		[self addSubview:self.socialButtons];
		
		UIImage *buttonBackgroundImage			= [[UIImage imageNamed:@"buttonBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 27.0, 5.0)];
		//UIImage *buttonPressedBackgroundImage	= [[UIImage imageNamed:@"buttonBgPressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8.0, 4.0, 29.0, 4.0)];
		UIFont *socialFont			= [UIFont boldSystemFontOfSize:kDSDefaultFontSize];
		UIColor *socialFontColor	= [UIColor lightGrayColor];
		
		
		
		self.likeButton			= [UIButton buttonWithType:UIButtonTypeCustom];
		self.likeButton.frame	= CGRectMake(0.0,
											 0.0,
											 44.0,
											 33.0);
		[self.likeButton setTitle:@"2" forState:UIControlStateNormal];
		[self.likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 0.0)];
		[self.likeButton.titleLabel setFont:socialFont];
		[self.likeButton setTitleColor:socialFontColor forState:UIControlStateNormal];
		[self.likeButton setImage:[UIImage imageNamed:@"paperClipIcon.png"] forState:UIControlStateNormal];
		[self.likeButton setBackgroundImage:buttonBackgroundImage			forState:UIControlStateNormal];
		//[self.likeButton setBackgroundImage:buttonPressedBackgroundImage	forState:UIControlStateHighlighted];
		
		[self.socialButtons addSubview:self.likeButton];
		
		self.commentButton			= [UIButton buttonWithType:UIButtonTypeCustom];
		self.commentButton.frame	= CGRectMake(44.0 + 2.0,
												 0.0,
												 44.0,
												 33.0);
		[self.commentButton setTitle:@"4" forState:UIControlStateNormal];
		[self.commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 0.0)];
		[self.commentButton.titleLabel setFont:socialFont];
		[self.commentButton setTitleColor:socialFontColor forState:UIControlStateNormal];
		[self.commentButton setImage:[UIImage imageNamed:@"commentIcon.png"] forState:UIControlStateNormal];
		[self.commentButton setBackgroundImage:buttonBackgroundImage			forState:UIControlStateNormal];
		
		[self.socialButtons addSubview:self.commentButton];
    }
    return self;
}

/**
 * Ricalcola le dimensioni e le posizioni di tutti gli elementi che dipendono dall'altezza del label
 * della descrizione il quale, essendo variabile, cambia dimensione quando viene aggiornato il testo.
 */
- (void) recalculateSizes
{
	CGRect descriptionLabelFrame	= self.descriptionLabel.frame;
	CGRect infoLabelsFrame			= self.infoLabels.frame;
	CGRect socialButtonsFrame		= self.socialButtons.frame;
	
	float descriptionLabelHeight = [self.descriptionLabel.text sizeWithFont:[UIFont systemFontOfSize:kDSCellDescriptionFontSize]
														  constrainedToSize:CGSizeMake(kDSCellDescriptionWidth, FLT_MAX)
															  lineBreakMode:UILineBreakModeWordWrap].height;
	
	self.infoLabels.frame		= CGRectMake(infoLabelsFrame.origin.x,
											 descriptionLabelHeight + descriptionLabelFrame.origin.y + 4.0,
											 infoLabelsFrame.size.width,
											 infoLabelsFrame.size.height);
	
	self.socialButtons.frame	= CGRectMake(socialButtonsFrame.origin.x,
											 descriptionLabelFrame.origin.y + descriptionLabelHeight + 4.0 + infoLabelsFrame.size.height + 4.0,
											 socialButtonsFrame.size.width,
											 socialButtonsFrame.size.height);
	
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
	self.avatarImageView.frame			= CGRectOffset(self.avatarImageView.frame, 0.0, deltaY);
	self.shadowAvatarImageView.frame	= CGRectOffset(self.shadowAvatarImageView.frame, 0.0, deltaY);
	self.usernameLabel.frame			= CGRectOffset(self.usernameLabel.frame, 0.0, deltaY);
	self.descriptionLabel.frame			= CGRectOffset(self.descriptionLabel.frame, 0.0, deltaY);
	self.infoLabels.frame				= CGRectOffset(self.infoLabels.frame, 0.0, deltaY);
	self.socialButtons.frame			= CGRectOffset(self.socialButtons.frame, 0.0, deltaY);
}

/**
 * Setta la descrizione e la data, calcolando la dimensione dei label e riaggiustando la view
 */
- (void) setGeoLocation:(NSString *)geoLocation andTime:(NSString *)aTime
{
	UIFont *infoFont = [UIFont boldSystemFontOfSize:kDSDefaultSmallFontSize];
	
	CGFloat geoLocationLabelWidth	= MIN([geoLocation sizeWithFont:infoFont].width, 140.0);
	CGFloat timeLabelWidth			= MIN([aTime sizeWithFont:infoFont].width, 140.0);
	
	self.geoLocationLabel.frame		= CGRectMake(self.geoLocationLabel.frame.origin.x,
												 self.geoLocationLabel.frame.origin.y,
												 geoLocationLabelWidth,
												 self.geoLocationLabel.frame.size.height);
	
	self.separatorImageView.frame	= CGRectMake(self.geoLocationLabel.frame.origin.x + self.geoLocationLabel.frame.size.width + 2.0,
												 self.separatorImageView.frame.origin.y,
												 self.separatorImageView.frame.size.width,
												 self.separatorImageView.frame.size.height);
	
	self.timeImageView.frame		= CGRectMake(self.separatorImageView.frame.origin.x + self.separatorImageView.frame.size.width + 2.0,
												 self.timeImageView.frame.origin.y,
												 self.timeImageView.frame.size.width,
												 self.timeImageView.frame.size.height);
	
	self.timeLabel.frame			= CGRectMake(self.timeImageView.frame.origin.x + self.timeImageView.frame.size.width + 2.0,
												 self.timeLabel.frame.origin.y,
												 timeLabelWidth,
												 self.timeLabel.frame.size.height);
	
	self.geoLocationLabel.text	= geoLocation;
	self.timeLabel.text			= aTime;
	
	
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
