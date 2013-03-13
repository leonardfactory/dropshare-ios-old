//
//  DSImageJournalCell.m
//  Shabaka
//
//  Created by Leonardo Ascione on 11/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DSImageJournalCell.h"
#import "UIImageView+AFNetworking.h"
#import "InterfaceConstants.h"

@implementation DSImageJournalCell

+ (CGFloat) heightForCellWithText:(NSString *) text
{
	return [super heightForCellWithText:text] + kDSCellPictureHeight + kDSCellPictureBottomMargin;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14.0, 14.0, 292.0, kDSCellPictureHeight)];
		[self shiftContent:self.pictureImageView.frame.size.height + kDSCellPictureBottomMargin];
		[self addSubview:self.pictureImageView];
		
		self.pictureImageView.layer.cornerRadius = kDSCellPictureCornerRadius;
		self.pictureImageView.layer.masksToBounds = YES;
		
		self.shadowPictureImageView = [[UIImageView alloc] initWithFrame:self.pictureImageView.frame];
		self.shadowPictureImageView.image = [[UIImage imageNamed:@"innerShadow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)];
		self.shadowPictureImageView.alpha = kDSCellInnerShadowAlpha;
		[self addSubview:self.shadowPictureImageView];
    }
    return self;
}

- (void) setPictureWithURL:(NSURL *) imageURL
{
	[self.pictureImageView setImageWithURL:imageURL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
