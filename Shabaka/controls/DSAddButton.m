//
//  DSAddButton.m
//  Shabaka
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSAddButton.h"

@interface DSAddButton ()
{
	DSAddButtonState _state;
	float marginToBeInvisible;
}

@property (strong, nonatomic) NSArray *actions;
@property (strong, nonatomic) NSMutableArray *actionButtons;

@property (strong, nonatomic) UIImageView *buttonImageView;

@end

@implementation DSAddButton

@synthesize actions = _actions;
@synthesize actionButtons = _actionButtons;

- (id)initWithFrame:(CGRect)frame andActions:(NSArray *)actions
{
    self = [super initWithFrame:frame];
    if (self)
	{
        self.buttonImageView		= [[UIImageView alloc] initWithFrame:self.frame];
		self.buttonImageView.image	= [UIImage imageNamed:@"addButton.png"];
		[self addSubview:self.buttonImageView];
		
		_state = DSAddButtonStateClosed;
		
		_actions = actions;
		_actionButtons = [NSMutableArray arrayWithCapacity:[_actions count]];
		
		marginToBeInvisible = kDSAddButtonSize / 2.0 - kDSActionButtonSize / 2.0;
		
		for(NSString* action in _actions)
		{
			DSActionButton *actionButton = [[DSActionButton alloc] initWithFrame:CGRectMake(marginToBeInvisible, marginToBeInvisible, kDSActionButtonSize, kDSActionButtonSize)];
			[actionButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", action]] forState:UIControlStateNormal];
			[self insertSubview:actionButton belowSubview:self.buttonImageView];
			
			[_actionButtons addObject:action];
		}
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	
	if(CGRectContainsPoint(self.buttonImageView.frame, location))
	{
		[self showButtons];
	}
}

- (void) showButtons
{
	if(_state != DSAddButtonStateClosed)
	{
		return;
	}
	
	_state = DSAddButtonStateOpening;
	
	[UIView animateWithDuration:kDSAddButtonShowAnimationTime animations:^{
		// pop up buttons
		for(int i = 0; i < [_actionButtons count]; i++)
		{
			[[_actionButtons objectAtIndex:i] setFrame:CGRectMake(marginToBeInvisible,
																  kDSAddButtonSize + (kDSActionButtonMargin + kDSActionButtonSize) * i,
																  kDSActionButtonSize,
																  kDSActionButtonSize)];
		}
		
		// rotate 45 degrees
		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/4.0);
        self.buttonImageView.transform = transform;
		
	} completion:^(BOOL finished) {
		_state = DSAddButtonStateOpened;
	}];
}

@end
