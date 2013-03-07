//
//  DSPaddedTextField.m
//  Shabaka
//
//  Created by Leonardo Ascione on 07/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSPaddedTextField.h"

@implementation DSPaddedTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect) bounds
{
	return CGRectInset(bounds, 5, 5);
}

- (CGRect)editingRectForBounds:(CGRect) bounds
{
	return CGRectInset(bounds, 5, 5);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end