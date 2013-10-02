//
//  DSLoginViewController.h
//  Movover
//
//  Created by Leonardo Ascione on 07/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSProfileManager.h"
#import "DSPaddedTextField.h"

#define DS_KEYBOARD_SHIFT 80.0

typedef enum _DSLoginAnimationState
{
	DSLoginAnimationStateMoveUp = 0,
	DSLoginAnimationStateMoveDown,
	DSLoginAnimationStateNone
} DSLoginAnimationState;

typedef struct
{
	CGPoint originalCenter;
	DSLoginAnimationState animation;
	BOOL animateKeyboard;
} LoginViewState;

@protocol DSLoginViewControllerDelegate  <NSObject>

- (void) dismissLoginViewController;

@end

@interface DSLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) id<DSLoginViewControllerDelegate> delegate;

@end
