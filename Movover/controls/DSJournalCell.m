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
{
    DSButtonAnimationState likeAnimationState;
}

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
		[self addSubview:self.self.mainBackgroundView];
		
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
        
        // predispongo lo stato dell'animazione
        likeAnimationState = DSButtonAnimationNone;
        
        
		self.socialButtons	= [[UIView alloc] initWithFrame:CGRectMake(kDSCellInfoLabelsLeftMargin,
																	   self.infoLabels.frame.origin.y + self.infoLabels.frame.size.height + kDSCellInfoLabelsSpacing,
																	   kDSCellLabelWidth,
																	   kDSCellSocialBarHeight)];
        [self addSubview:self.socialButtons];
		
		//UIImage *buttonBackgroundImage			= [[UIImage imageNamed:@"buttonBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 27.0, 5.0)];
		//UIImage *buttonPressedBackgroundImage	= [[UIImage imageNamed:@"buttonBgPressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8.0, 4.0, 29.0, 4.0)];
		UIFont *socialFont              = [UIFont boldSystemFontOfSize:kDSDefaultFontSize];
		UIColor *socialFontColor        = [UIColor colorWithRed:0./255. green:186./255. blue:115./255. alpha:1.0];
        UIColor *socialBackgroundColor  = [UIColor colorWithRed:245./255. green:245./255. blue:245./255. alpha:1.0];
		
		// Like Button
		FIIcon *likeIcon        = [FIEntypoIcon heartIcon];
		self.likeButton			= [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.tag     = 1;
		self.likeButton.frame	= CGRectMake(0.0,
											 kDSCellSocialButtonTopMargin,
											 kDSCellSocialButtonWidth,
											 kDSCellSocialButtonHeight);
        
        self.likeButton.layer.cornerRadius = kDSCellCornerRadius;
        
        [self.likeButton setBackgroundColor:socialBackgroundColor];
		[self.likeButton setTitle:@"2" forState:UIControlStateNormal];
		[self.likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 6.0, 0.0, 0.0)];
		[self.likeButton.titleLabel setFont:socialFont];
		[self.likeButton setTitleColor:socialFontColor forState:UIControlStateNormal];
		[self.likeButton setImage:[likeIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize)
                                                      color:socialFontColor]
                         forState:UIControlStateNormal];
		
		[self.socialButtons addSubview:self.likeButton];
		
        // Comment Button
        FIIcon *commentIcon         = [FIEntypoIcon commentIcon];
		self.commentButton			= [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentButton.tag      = 2;
		self.commentButton.frame	= CGRectMake(kDSCellSocialButtonWidth + kDSCellSocialBarSpacing,
												 kDSCellSocialButtonTopMargin,
												 kDSCellSocialButtonWidth,
												 kDSCellSocialButtonHeight);
        
        self.commentButton.layer.cornerRadius = kDSCellCornerRadius;
        
        [self.commentButton setBackgroundColor:socialBackgroundColor];
		[self.commentButton setTitle:@"4" forState:UIControlStateNormal];
		[self.commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 0.0)];
		[self.commentButton.titleLabel setFont:socialFont];
		[self.commentButton setTitleColor:socialFontColor forState:UIControlStateNormal];
        [self.commentButton setImage:[commentIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize)
                                                      color:socialFontColor]
                         forState:UIControlStateNormal];
		//[self.commentButton setBackgroundImage:buttonBackgroundImage			forState:UIControlStateNormal];
		
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
	
	self.socialButtons.frame	= CGRectMake(socialButtonsFrame.origin.x,
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
	self.socialButtons.frame			= CGRectOffset(self.socialButtons.frame, 0.0, deltaY);
}

/**
 * Changes buttons width based on text size
 */
- (void) updateCountForButton:(UIButton *)button withNumber:(NSNumber *)number
{
    [self updateCountForButton:button withNumber:number animating:YES];
}

- (void) updateCountForButton:(UIButton *)button withNumber:(NSNumber *)number animating:(BOOL) animating
{
    NSUInteger oldNumber = [button.currentTitle intValue];
    NSUInteger newNumber = [number intValue];
    
    NSString *oldNumberString = [NSString stringWithFormat:@"%u", oldNumber];
    NSString *newNumberString = [NSString stringWithFormat:@"%u", newNumber];
    
    BOOL shouldAnimate =    (oldNumberString.length != newNumberString.length) ||
                            ((oldNumber == 0 || newNumber == 0) && newNumber != oldNumber);
    
    // Animate only if affinity transformation is the Identity
    shouldAnimate = shouldAnimate && CGAffineTransformIsIdentity(button.transform);
    
    // Animate only if requested
    shouldAnimate = shouldAnimate && animating;
    
    NSString *newTitle = newNumber == 0 ? @"" : newNumberString;
    
    float oldTextWidth = [button.currentTitle sizeWithFont:[UIFont boldSystemFontOfSize:kDSDefaultFontSize] constrainedToSize:CGSizeMake(100.0, 0.0)].width;
    float newTextWidth = [newTitle sizeWithFont:[UIFont boldSystemFontOfSize:kDSDefaultFontSize] constrainedToSize:CGSizeMake(100.0, 0.0)].width;
    float diff = newTextWidth - oldTextWidth;
    
    float animationDuration = shouldAnimate ? 0.2f : 0.0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        // Change title
        [button setTitle:newTitle forState:UIControlStateNormal];
        
        // Update frame size
        CGRect bounds = button.bounds;
        CGRect newBounds = CGRectMake(bounds.origin.x, bounds.origin.y, newTextWidth + kDSCellSocialButtonBaseWidth, bounds.size.height);
        button.bounds = newBounds;
        
        // Update other buttons on the right
        NSInteger tag = button.tag + 1;
        UIButton *nextButton;
        while((nextButton = (UIButton *)[button.superview viewWithTag:tag]))
        {
            CGPoint center = nextButton.center;
            nextButton.center = CGPointMake(center.x + diff, center.y);
            tag++;
        }
    }];
}

- (BOOL) canPerformLike
{
    return likeAnimationState == DSButtonAnimationNone;
}

/**
 * Setta likes, comments e reactions
 */
- (void) setLikes:(NSNumber *) likes andComments:(NSNumber *) comments andReactions:(NSNumber *) reactions
{
    //[self.likeButton setTitle:[likes stringValue] forState:UIControlStateNormal];
    //[self.commentButton setTitle:[comments stringValue] forState:UIControlStateNormal];
    
    [self updateCountForButton:self.likeButton withNumber:likes];
    [self updateCountForButton:self.commentButton withNumber:comments];
}

/**
 * Changes only buttons styles, without changing text.
 */
- (void) applyUnlikeStyle
{
    UIColor *likeColor = [UIColor colorWithRed:0./255. green:186./255. blue:115./255. alpha:1.0];
    FIIcon *likeIcon = [FIEntypoIcon heartIcon];
    [self.likeButton setImage:[likeIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize) color:likeColor] forState:UIControlStateNormal];
    [self.likeButton setTitleColor:likeColor forState:UIControlStateNormal];
}

- (void) applyLikeStyle
{
    UIColor *likeColor = [UIColor colorWithRed:200./255. green:44./255. blue:44./255. alpha:1.0];
    FIIcon *likeIcon = [FIEntypoIcon heartIcon];
    [self.likeButton setImage:[likeIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize) color:likeColor] forState:UIControlStateNormal];
    [self.likeButton setTitleColor:likeColor forState:UIControlStateNormal];
}

/**
 * Animazione del like e dell'unlike
 */
- (void) animateUnlike
{
    if(likeAnimationState == DSButtonAnimationNone)
    {
        likeAnimationState = DSButtonAnimationUnlike;
        
        [self applyUnlikeStyle];
        
        [UIView animateWithDuration:0.2f
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             // Fade out, but not completely
                             self.likeButton.imageView.alpha = 0.3;
                             
                             self.likeButton.imageView.transform = CGAffineTransformMakeScale(3.0, 3.0); // CGAffineTransformScale(self.likeButton.imageView.transform, 3, 3);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2f
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.likeButton.imageView.alpha = 1.0;
                                                  self.likeButton.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0); //CGAffineTransformScale(self.likeButton.imageView.transform, 1, 1);
                                              }
                                              completion:^(BOOL finished) {
                                                  self.likeButton.imageView.transform = CGAffineTransformIdentity;
                                                  [self updateCountForButton:self.likeButton withNumber:[NSNumber numberWithInt:[self.likeButton.currentTitle intValue] - 1]];
                                                  likeAnimationState = DSButtonAnimationNone;
                                              }];
                         }];
    }
    /*else {
        [self updateCountForButton:self.likeButton withNumber:[NSNumber numberWithInt:[self.likeButton.currentTitle intValue] - 1] animating:false];
    }*/
}

/**
 * Animazione dell'unlike
 */
- (void) animateLike
{
    if(likeAnimationState == DSButtonAnimationNone)
    {
        likeAnimationState = DSButtonAnimationLike;
    
        [self applyLikeStyle];
        
        [UIView animateWithDuration:0.2f
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             // Fade out, but not completely
                             self.likeButton.imageView.alpha = 0.3;
                             
                             self.likeButton.imageView.transform = CGAffineTransformMakeScale(3.0, 3.0); // CGAffineTransformScale(self.likeButton.imageView.transform, 3, 3);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2f
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.likeButton.imageView.alpha = 1.0;
                                                  self.likeButton.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0); //CGAffineTransformScale(self.likeButton.imageView.transform, 1, 1);
                                              }
                                              completion:^(BOOL finished) {
                                                  self.likeButton.imageView.transform = CGAffineTransformIdentity;
                                                  [self updateCountForButton:self.likeButton withNumber:[NSNumber numberWithInt:[self.likeButton.currentTitle intValue] + 1]];
                                                  likeAnimationState = DSButtonAnimationNone;
                                              }];
                         }];
    }
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
