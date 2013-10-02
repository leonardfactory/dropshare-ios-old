//
//  DSPaddedTextField.m
//  Movover
//
//  Created by Leonardo Ascione on 07/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSPaddedTextField.h"

@implementation DSPaddedTextField

@synthesize nextField;

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
	return CGRectInset(bounds, 10, 5);
}

- (CGRect)editingRectForBounds:(CGRect) bounds
{
	return CGRectInset(bounds, 10, 5);
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
