//
//  DSImageJournalCell.m
//  Shabaka
//
//  Created by Leonardo Ascione on 11/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DSImageJournalCell.h"

#define kDSPictureHeight 160.0

@implementation DSImageJournalCell

+ (CGFloat) heightForCellWithText:(NSString *) text
{
	return [super heightForCellWithText:text] + kDSPictureHeight + 14.0;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14.0, 14.0, 292.0, kDSPictureHeight)];
		[self shiftContent:self.pictureImageView.frame.size.height + self.pictureImageView.frame.origin.y];
		[self addSubview:self.pictureImageView];
		
		self.pictureImageView.layer.cornerRadius = 3.0f;
		self.pictureImageView.layer.masksToBounds = YES;
    }
    return self;
}

- (void) setPictureImage:(UIImage *)image
{
	[self.pictureImageView setImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
