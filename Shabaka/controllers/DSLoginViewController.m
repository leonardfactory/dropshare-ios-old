//
//  DSLoginViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 07/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSLoginViewController.h"

@interface DSLoginViewController ()
{
	DSProfileManager *profileManager;
	LoginViewState state;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *fbSignupButton;

@end

@implementation DSLoginViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		profileManager = [[DSProfileManager alloc] initWithViewController:self];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	state.originalCenter = self.view.center;
	state.animation = DSLoginAnimationStateNone;
	state.animateKeyboard = YES;
	
	[self.fbSignupButton setBackgroundImage:[[UIImage imageNamed:@"fbButtonBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 6, 38, 5)] forState:UIControlStateNormal];
	[self.connectButton setBackgroundImage:[[UIImage imageNamed:@"connectButtonBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 6, 38, 5)] forState:UIControlStateNormal];
	
	[self.usernameField setBackground:[[UIImage imageNamed:@"textFieldTopBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 5, 44, 5)]];
	[self.passwordField setBackground:[[UIImage imageNamed:@"textFieldBottomBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 5, 44, 5)]];
}

#pragma mark - Keyboard handling
- (void)keyboardWillShow:(NSNotification *) note
{	
	if(state.animation == DSLoginAnimationStateNone && state.animateKeyboard == YES)
	{
		CGPoint movedCenter = CGPointMake(state.originalCenter.x, state.originalCenter.y - DS_KEYBOARD_SHIFT);
		[UIView animateWithDuration:0.3f
						 animations:^(void){
							 [self.view setCenter:movedCenter];
						 }
						 completion:^(BOOL finished){
							 state.animation = DSLoginAnimationStateNone;
						 }];
		
		state.animation = DSLoginAnimationStateMoveUp;
	}
	
	state.animateKeyboard = YES;
}

- (void)keyboardWillHide:(NSNotification *) note
{
	if(state.animation == DSLoginAnimationStateNone && state.animateKeyboard == YES)
	{
		[UIView animateWithDuration:0.3f
						 animations:^(void){
							 [self.view setCenter:state.originalCenter];
						 }
						 completion:^(BOOL finished){
							 state.animation = DSLoginAnimationStateNone;
						 }];
		
		state.animation = DSLoginAnimationStateMoveDown;
	}
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
	DSPaddedTextField* paddedTextField = nil;
	
	if ([textField isKindOfClass:[DSPaddedTextField class]])
	{
		paddedTextField = (DSPaddedTextField *) textField;
		state.animateKeyboard = ([paddedTextField nextField] == nil) ? YES : NO;
	}
	else
	{
		state.animateKeyboard = YES;
	}
	
    BOOL didResign = [textField resignFirstResponder];
    if (!didResign) return NO;
	
    if (paddedTextField)
	{
		[[paddedTextField nextField] becomeFirstResponder];
	}
	
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *) textField
{
	if([textField isKindOfClass:[DSPaddedTextField class]])
	{
		DSPaddedTextField *paddedTextField = (DSPaddedTextField *) textField;
		if(paddedTextField.nextField)
		{
			paddedTextField.returnKeyType = UIReturnKeyNext;
		}
		else
		{
			paddedTextField.returnKeyType = UIReturnKeyDone;
		}
	}
}

- (void) textFieldDidEndEditing:(UITextField *) textField
{
	//
}

#pragma mark - Button Actions
- (IBAction)connectButtonPressed:(id) sender
{
	[self loginUser:sender];
}

- (IBAction)signupButtonPressed:(id) sender
{
	[self signUpWithFacebook:sender];
}

#pragma  mark Network Actions
- (void) loginUser:(id) sender
{
	[self.delegate dismissLoginViewController]; // @todo remove
	//[profileManager loginWithUsername:self.usernameField.text withPassword:self.passwordField.text];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"user"] && [object isEqual:profileManager.domain])
	{
		/*
		if([profileManager isJustLogged])
		{
			profileManager.isJustLogged = FALSE;
			NSLog(@"%@",[(ProfileDomain *)profileManager.domain user]);
			
			[self.delegate dismissLoginViewController];
		}
	}
	
	if([keyPath isEqualToString:@"error"] && [object isEqual:profileManager.domain])
	{
		if ([(ProfileDomain *)[profileManager domain] error])
		{
			NSLog(@"%@", [(ProfileDomain *)[profileManager domain] error]);
			
			[(ProfileDomain *)[profileManager domain] setError:nil];
			[profileManager.dataAdapter save];
		}
		 */
	}
}

- (void) signUpWithFacebook:(id) sender
{
	
}

#pragma mark - Closing view
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
	[self setUsernameField:nil];
	[self setPasswordField:nil];
	[self setConnectButton:nil];
	[self setFbSignupButton:nil];
	[super viewDidUnload];
}
@end
