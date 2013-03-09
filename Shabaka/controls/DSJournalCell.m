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

- (void) setAvatarImage:(UIImage *)image
{
	[self.imageView setImage:image];
	
	[self.imageView.layer setCornerRadius:DS_AVATAR_ROUNDED_CORNERS];
	[self.imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
	[self.imageView.layer setBorderWidth:1.0f];
	[self.imageView.layer setShadowColor:[UIColor blackColor].CGColor];
	[self.imageView.layer setShadowOpacity:0.8];
	[self.imageView.layer setShadowRadius:DS_AVATAR_SHADOW_SIZE];
	[self.imageView.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
