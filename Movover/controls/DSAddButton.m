//
//  DSAddButton.m
//  Movover
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSAddButton.h"

@interface DSAddButton ()
{
	DSAddButtonState _state;
	float marginToBeInvisible;
	CGRect openedRect;
}

@property (strong, nonatomic) NSArray *actions;
@property (strong, nonatomic) NSMutableArray *actionButtons;

@property (strong, nonatomic) UIImageView *buttonImageView;

@end

@implementation DSAddButton

@synthesize actionCalled;
@synthesize actions = _actions;
@synthesize actionButtons = _actionButtons;

- (id)initWithFrame:(CGRect)frame andActions:(NSArray *)actions
{
    self = [super initWithFrame:frame];
    if (self)
	{
        self.buttonImageView		= [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kDSAddButtonSize, kDSAddButtonSize)];
		self.buttonImageView.image	= [UIImage imageNamed:@"addButton.png"];
		
		[self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.buttonImageView];
		
		_state = DSAddButtonStateClosed;
		
		_actions = actions;
		_actionButtons = [NSMutableArray arrayWithCapacity:[_actions count]];
		
		marginToBeInvisible = kDSAddButtonSize / 2.0 - kDSActionButtonSize / 2.0;
		openedRect = CGRectMake(self.buttonImageView.frame.origin.x,
								self.buttonImageView.frame.origin.y - [_actions count] * (kDSActionButtonMargin + kDSActionButtonSize),
								self.buttonImageView.frame.size.width,
								self.buttonImageView.frame.size.height + [_actions count] * (kDSActionButtonMargin + kDSActionButtonSize));
		
		for(NSString* action in _actions)
		{
			DSActionButton *actionButton = [[DSActionButton alloc] initWithFrame:CGRectMake(marginToBeInvisible, marginToBeInvisible, kDSActionButtonSize, kDSActionButtonSize)];
			[actionButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", action]] forState:UIControlStateNormal];
			
			[actionButton setActionName:action];
			[actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			
			actionButton.userInteractionEnabled = NO;
			[self insertSubview:actionButton belowSubview:self.buttonImageView];
			
			[_actionButtons addObject:actionButton];
		}
    }
    return self;
}

/* - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
 {
 [super touchesEnded:touches withEvent:event];
 UITouch *touch = [touches anyObject];
 CGPoint location = [touch locationInView:self.superview];
 
 if(CGRectContainsPoint(self.buttonImageView.frame, location))
 {
 [self showButtons];
 }
 } */

- (void) touchUpInside
{
	if(_state == DSAddButtonStateClosed || _state == DSAddButtonStateClosing)
	{
		[self showButtons];
	}
	
	if(_state == DSAddButtonStateOpened || _state == DSAddButtonStateClosing)
	{
		[self closeButtons];
	}
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	if(_state == DSAddButtonStateClosing || _state == DSAddButtonStateOpening)
	{
		return NO;
	}
	
	if(_state == DSAddButtonStateOpened)
	{
		if (CGRectContainsPoint(openedRect, point))
		{
			return YES;
		}
	}
	else
	{
		if( CGRectContainsPoint(self.buttonImageView.frame, point))
		{
			return YES;
		}
	}
	return NO;
}

- (void) showButtons
{
	if(_state != DSAddButtonStateClosed)
	{
		return;
	}
	
	_state = DSAddButtonStateOpening;
	
	[UIView animateWithDuration:kDSAddButtonShowAnimationTime delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
		// pop up buttons
		for(int i = 0; i < [_actionButtons count]; i++)
		{
			[[_actionButtons objectAtIndex:i] setFrame:CGRectMake(marginToBeInvisible,
																  - kDSAddButtonSize - ((kDSActionButtonMargin + kDSActionButtonSize) * i),
																  kDSActionButtonSize,
																  kDSActionButtonSize)];
		}
		
		// rotate 45 degrees
		CGAffineTransform transform = CGAffineTransformMakeRotation(3*M_PI/4.0);
        self.buttonImageView.transform = transform;
		
	} completion:^(BOOL finished) {
		_state = DSAddButtonStateOpened;
		
		for(DSActionButton *actionButton in _actionButtons)
		{
			actionButton.userInteractionEnabled = YES;
		}
	}];
}

- (void) closeButtons
{
	if(_state != DSAddButtonStateOpened)
	{
		return;
	}
	
	_state = DSAddButtonStateClosing;
	
	[UIView animateWithDuration:kDSAddButtonShowAnimationTime delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
		// pop up buttons
		for(int i = 0; i < [_actionButtons count]; i++)
		{
			DSActionButton *actionButton = [_actionButtons objectAtIndex:i];
			actionButton.userInteractionEnabled = NO;
			[actionButton setFrame:CGRectMake(marginToBeInvisible,
											  marginToBeInvisible,
											  kDSActionButtonSize,
											  kDSActionButtonSize)];
		}
		
		// rotate 45 degrees
		CGAffineTransform transform = CGAffineTransformMakeRotation(0.0);
        self.buttonImageView.transform = transform;
		
	} completion:^(BOOL finished) {
		_state = DSAddButtonStateClosed;
	}];
}

- (void) actionButtonPressed:(id) sender
{
	assert([sender isKindOfClass:[DSActionButton class]]);
	[self setActionCalled:((DSActionButton *)sender).actionName];
}

@end
