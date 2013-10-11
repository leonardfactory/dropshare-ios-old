//
//  DSJournalCell.m
//  Movover
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DSJournalCell.h"
#import "InterfaceConstants.h"
#import "UIImageView+AFNetworking.h"

@interface DSJournalCell ()

@end

@implementation DSJournalCell

@synthesize identifier = _identifier;

+ (CGFloat) heightForCellWithText:(NSString *)text
{
	CGFloat textLabelHeight = [text sizeWithFont:[UIFont systemFontOfSize:kDSCellDescriptionFontSize]
							   constrainedToSize:CGSizeMake(kDSCellDescriptionWidth, FLT_MAX)
								   lineBreakMode:NSLineBreakByWordWrapping].height;
	
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
        UIColor *textColor      = [UIColor colorWithWhite:0.15 alpha:1.0];
        UIColor *nameColor      = [UIColor lightGrayColor];
        //UIColor *usernameColor  = [UIColor colorWithRed:76./255. green:172./255. blue:186./255. alpha:1.0];
        
		// Per ogni elemento della view aggiunto, bisogna aggiungere il CGRectOffset per spostarlo in shiftContent
		// @todo Aggiungere weakReferences
		self.frame				= CGRectMake(0.0, 0.0, kDSCellWidth, kDSCellHeight);
		self.backgroundColor	= [UIColor clearColor];
		self.autoresizingMask	= (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		
		self.mainBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(kDSCellBackgroundMargin, kDSCellBackgroundMargin, kDSCellBackgroundWidth, kDSCellBackgroundHeight)];
        self.mainBackgroundView.backgroundColor = [UIColor whiteColor];
        self.mainBackgroundView.layer.cornerRadius = kDSCellCornerRadius;
		//[self.mainBackgroundImageView setImage:[[UIImage imageNamed:@"mainBgTile.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6.0, 8.0, 10.0, 8.0)]];
		self.mainBackgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
		[self addSubview:self.mainBackgroundView];
		
		// Avatar frame e inner shadow
		self.avatarImageView						= [[UIImageView alloc] initWithFrame:CGRectMake(kDSCellAvatarLeftMargin, kDSCellAvatarTopMargin, kDSCellAvatarSize, kDSCellAvatarSize)];
		self.avatarImageView.layer.cornerRadius		= kDSCellAvatarCornerRadius;
		self.avatarImageView.layer.masksToBounds	= YES;
		[self addSubview:self.avatarImageView];
		
		/*self.shadowAvatarImageView			= [[UIImageView alloc] initWithFrame:self.avatarImageView.frame];
		self.shadowAvatarImageView.image	= [[UIImage imageNamed:@"innerShadow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
		self.shadowAvatarImageView.alpha	= kDSCellInnerShadowAlpha;
		[self addSubview:self.shadowAvatarImageView];*/
		
        self.nameLabel                      = [[UILabel alloc] initWithFrame:CGRectMake(kDSCellLabelLeftMargin, kDSCellNameTopMargin, 100.0, kDSCellNameHeight)];
        self.nameLabel.backgroundColor      = [UIColor whiteColor];
        self.nameLabel.font                 = [UIFont boldSystemFontOfSize:kDSCellNameFontSize];
        self.nameLabel.textColor            = textColor;
        self.nameLabel.text                 = @"Name";
        [self addSubview:self.nameLabel];
        
		self.usernameLabel					= [[UILabel alloc] initWithFrame:CGRectMake(kDSCellLabelLeftMargin, kDSCellUsernameTopMargin, 100.0, kDSCellUsernameHeight)];
		self.usernameLabel.backgroundColor	= [UIColor whiteColor]; // +speed
		self.usernameLabel.font				= [UIFont boldSystemFontOfSize:kDSCellUsernameFontSize];
		self.usernameLabel.textColor		= nameColor;
		self.usernameLabel.text				= @"Username";
		[self addSubview:self.usernameLabel];
		
		self.descriptionLabel					= [[UILabel alloc] initWithFrame:CGRectMake(kDSCellLabelLeftMargin, kDSCellDescriptionTopMargin, kDSCellDescriptionWidth, kDSCellDescriptionHeight)];
		self.descriptionLabel.backgroundColor	= [UIColor clearColor];
        self.descriptionLabel.textColor         = textColor;
		self.descriptionLabel.font				= [UIFont systemFontOfSize:kDSCellDescriptionFontSize];
		self.descriptionLabel.lineBreakMode		= NSLineBreakByWordWrapping;
		self.descriptionLabel.numberOfLines		= 0; // Automatically \n
		self.descriptionLabel.text				= @"Description text";
        //self.descriptionLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
		[self addSubview:self.descriptionLabel];
		
		// Info on GeoLocation and Time
		UIFont *infoFont		= [UIFont boldSystemFontOfSize:kDSDefaultFontSize];
		UIColor *infoFontColor	= [UIColor lightGrayColor];
        
        //UIFont *entypoFont      = [UIFont fontWithName:@"Entypo" size:kDSDefaultSmallFontSize];
		
		self.infoLabels		= [[UIView alloc] initWithFrame:CGRectMake(kDSCellBackgroundMargin,
																	   kDSCellDescriptionTopMargin + kDSCellDescriptionHeight + kDSCellInfoLabelsTopMargin,
																	   kDSCellBackgroundWidth,
																	   kDSCellInfoLabelsHeight)];
        self.infoLabels.backgroundColor             = [UIColor colorWithRed:250./255. green:250./255. blue:250./255. alpha:1.0];
		[self addSubview:self.infoLabels];
        
		//self.geoLocationImageView		= [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 2.0, 10.0, 10.0)];
		//self.geoLocationImageView.image = [UIImage imageNamed:@"geoLocationIcon.png"];
		//[self.infoLabels addSubview:self.geoLocationImageView];
        
        self.geoLocationIconView                    = [[FIIconView alloc] initWithFrame:CGRectMake(kDSCellInfoLabelsLeftMargin,
                                                                                                   kDSCellInfoLabelsIconTopMargin,
                                                                                                   kDSCellInfoLabelsIconHeight,
                                                                                                   kDSCellInfoLabelsIconHeight)];
        self.geoLocationIconView.backgroundColor    = [UIColor clearColor];
        self.geoLocationIconView.icon               = [FIEntypoIcon locationIcon];
        self.geoLocationIconView.padding            = 2;
        self.geoLocationIconView.iconColor          = infoFontColor;
        [self.infoLabels addSubview:self.geoLocationIconView];
		
		self.geoLocationLabel			= [[UILabel alloc] initWithFrame:CGRectMake(self.geoLocationIconView.frame.origin.x + self.geoLocationIconView.frame.size.width + kDSCellInfoLabelsSpacing,
                                                                                    kDSCellInfoLabelsTopMargin,
                                                                                    100.0,
                                                                                    kDSCellInfoLabelsInnerHeight)];
		self.geoLocationLabel.text		= @"Placeholder";
		self.geoLocationLabel.font		= infoFont;
		self.geoLocationLabel.textColor = infoFontColor;
		[self.infoLabels addSubview:self.geoLocationLabel];
		
		/*self.separatorImageView			= [[UIImageView alloc] initWithFrame:CGRectMake(self.geoLocationLabel.frame.origin.x + self.geoLocationLabel.frame.size.width + kDSCellInfoLabelsSpacing,
                                                                                        kDSCellInfoLabelsTopMargin + (kDSCellInfoLabelsInnerHeight - 2.0) / 2.,
                                                                                        2.0,
                                                                                        2.0)]; */
		//self.separatorImageView.image	= [UIImage imageNamed:@"dotSeparator.png"];
		//[self.infoLabels addSubview:self.separatorImageView];
        
        self.timeIconView                    = [[FIIconView alloc] initWithFrame:CGRectMake(self.geoLocationLabel.frame.origin.x + self.geoLocationLabel.frame.size.width + (kDSCellInfoLabelsSpacing * 2),
                                                                                            kDSCellInfoLabelsIconTopMargin,
                                                                                            kDSCellInfoLabelsIconHeight,
                                                                                            kDSCellInfoLabelsIconHeight)];
        self.timeIconView.backgroundColor    = [UIColor clearColor];
        self.timeIconView.icon               = [FIEntypoIcon clockIcon];
        self.timeIconView.padding            = 2;
        self.timeIconView.iconColor          = infoFontColor;
        [self.infoLabels addSubview:self.timeIconView];
		
		//self.timeImageView			= [[UIImageView alloc] initWithFrame:CGRectMake(120.0, 1.0, 11.0, 11.0)];
		//self.timeImageView.image	= [UIImage imageNamed:@"timeIcon.png"];
		//[self.infoLabels addSubview:self.timeImageView];
		
		self.timeLabel				= [[UILabel alloc] initWithFrame:CGRectMake(self.timeIconView.frame.origin.x + self.timeIconView.frame.size.width + kDSCellInfoLabelsSpacing,
                                                                                kDSCellInfoLabelsTopMargin,
                                                                                100.0,
                                                                                kDSCellInfoLabelsInnerHeight)];
		self.timeLabel.text			= @"11/02/2012";
		self.timeLabel.font			= infoFont;
		self.timeLabel.textColor	= infoFontColor;
		[self.infoLabels addSubview:self.timeLabel];
        
		
		// Comments and Social buttons / indicator
		self.socialButtonsBarView	= [[DSSocialButtonsBarView alloc] initWithFrame:CGRectMake(kDSCellInfoLabelsLeftMargin,
																	   self.infoLabels.frame.origin.y + self.infoLabels.frame.size.height + kDSCellInfoLabelsSpacing,
																	   kDSCellLabelWidth,
																	   kDSCellSocialBarHeight)];
        [self addSubview:self.socialButtonsBarView];
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
	CGRect socialButtonsFrame		= self.socialButtonsBarView.frame;
    
    float nameLabelWidth            = [self.nameLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:kDSCellNameFontSize]].width;
    
    self.nameLabel.frame        = CGRectMake(self.nameLabel.frame.origin.x,
                                             self.nameLabel.frame.origin.y,
                                             nameLabelWidth,
                                             self.nameLabel.frame.size.height);
    
    self.usernameLabel.frame    = CGRectMake(kDSCellLabelLeftMargin + nameLabelWidth + 5.0,
                                             self.nameLabel.frame.origin.y + (kDSCellNameHeight - kDSCellUsernameHeight) - 1.0,
                                             kDSCellLabelWidth - nameLabelWidth - 5.0,
                                             self.usernameLabel.frame.size.height);
	
	float descriptionLabelHeight = [self.descriptionLabel.text sizeWithFont:[UIFont systemFontOfSize:kDSCellDescriptionFontSize]
														  constrainedToSize:CGSizeMake(kDSCellDescriptionWidth, FLT_MAX)
															  lineBreakMode:NSLineBreakByWordWrapping].height;
	
	self.infoLabels.frame		= CGRectMake(infoLabelsFrame.origin.x,
											 descriptionLabelHeight + descriptionLabelFrame.origin.y + kDSCellInfoLabelsTopMargin,
											 infoLabelsFrame.size.width,
											 infoLabelsFrame.size.height);
	
	self.socialButtonsBarView.frame	= CGRectMake(socialButtonsFrame.origin.x,
                                                 self.infoLabels.frame.origin.y + self.infoLabels.frame.size.height + kDSCellInfoLabelsSpacing,
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
    self.nameLabel.frame                = CGRectOffset(self.nameLabel.frame, 0.0, deltaY);
	self.usernameLabel.frame			= CGRectOffset(self.usernameLabel.frame, 0.0, deltaY);
	self.descriptionLabel.frame			= CGRectOffset(self.descriptionLabel.frame, 0.0, deltaY);
	self.infoLabels.frame				= CGRectOffset(self.infoLabels.frame, 0.0, deltaY);
	self.socialButtonsBarView.frame		= CGRectOffset(self.socialButtonsBarView.frame, 0.0, deltaY);
}

#pragma mark - Animate like or unlike
- (BOOL) canPerformLike
{
    return [self.socialButtonsBarView canPerformLike];
}

/**
 * Setta la descrizione e la data, calcolando la dimensione dei label e riaggiustando la view
 */
- (void) setGeoLocation:(NSString *)geoLocation andTime:(NSString *)aTime
{
	UIFont *infoFont = [UIFont boldSystemFontOfSize:kDSDefaultFontSize];
	
	CGFloat geoLocationLabelWidth	= MIN([geoLocation sizeWithFont:infoFont].width, 140.0);
	CGFloat timeLabelWidth			= 140.; //MIN([aTime sizeWithFont:infoFont].width, 310.0);
	
	self.geoLocationLabel.frame		= CGRectMake(self.geoLocationLabel.frame.origin.x,
												 self.geoLocationLabel.frame.origin.y,
												 geoLocationLabelWidth,
												 self.geoLocationLabel.frame.size.height);
	
	self.timeIconView.frame         = CGRectMake(self.geoLocationLabel.frame.origin.x + geoLocationLabelWidth + (kDSCellInfoLabelsSpacing * 2),
												 self.timeIconView.frame.origin.y,
												 self.timeIconView.frame.size.width,
												 self.timeIconView.frame.size.height);
	
	self.timeLabel.frame			= CGRectMake(self.timeIconView.frame.origin.x + self.timeIconView.frame.size.width + kDSCellInfoLabelsSpacing,
												 self.timeLabel.frame.origin.y,
												 timeLabelWidth,
												 self.timeLabel.frame.size.height);
	
	self.geoLocationLabel.text	= geoLocation;
	self.timeLabel.text			= aTime;
	
	
}

- (void) setAvatarWithURL:(NSURL *) imageURL
{
	[self.avatarImageView setImageWithURL:imageURL];
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
