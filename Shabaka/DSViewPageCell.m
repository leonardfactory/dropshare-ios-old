//
//  DSViewPageCell.m
//  Shabaka
//
//  Created by Leonardo Ascione on 26/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSViewPageCell.h"

@interface DSViewPageCell ()

@end

@implementation DSViewPageCell

- (id) init
{
	if(self = [super init])
	{
		NSArray* topLevelViews = [[NSBundle mainBundle] loadNibNamed:@"DSViewPageCell" owner:self options:nil];
		self = (DSViewPageCell *)[topLevelViews objectAtIndex:0];
	}
	return self;
}

@end
