//
//  DSLoginViewController.m
//  Movover
//
//  Created by Leonardo Ascione on 07/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DSLoginViewController.h"

#import "UIDevice+VersionCheck.h"

@interface DSLoginViewController ()
{
	LoginViewState state;
}
@property (strong, nonatomic) DSTokenManager *tokenManager;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *fbSignupButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
//@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation DSLoginViewController

@synthesize tokenManager = _tokenManager;

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		_tokenManager = [[DSTokenManager alloc] init];
		[_tokenManager addObserver:self forKeyPath:@"isJustLogged" options:NSKeyValueObservingOptionNew context:nil];
		[_tokenManager addObserver:self forKeyPath:@"errorString" options:NSKeyValueObservingOptionNew context:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Loaded login");
    
    // Customize navigation bar
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.navigationItem.titleView = imageView;
    
    
    if ([[UIDevice currentDevice] systemMajorVersion] >= 7)
    {
        // iOS 7
        self.navigationBar.frame = CGRectMake(self.navigationBar.frame.origin.x, self.navigationBar.frame.origin.y, self.navigationBar.frame.size.width, 64);
        [self.navigationBar setTranslucent:NO];
    }
	
	state.originalCenter = self.view.center;
	state.animation = DSLoginAnimationStateNone;
	state.animateKeyboard = YES;
	
    // Username Field corners
    UIBezierPath *usernameRounded;
    usernameRounded = [UIBezierPath bezierPathWithRoundedRect:self.usernameField.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(6.0, 6.0)];
    
    CAShapeLayer *usernameMaskLayer = [[CAShapeLayer alloc] init];
    usernameMaskLayer.frame = self.view.bounds;
    usernameMaskLayer.path = usernameRounded.CGPath;
    self.usernameField.layer.mask = usernameMaskLayer;
    
    // Password Field corners
    UIBezierPath *passwordRounded;
    passwordRounded = [UIBezierPath bezierPathWithRoundedRect:self.passwordField.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(6.0, 6.0)];
    
    CAShapeLayer *passwordMaskLayer = [[CAShapeLayer alloc] init];
    passwordMaskLayer.frame = self.view.bounds;
    passwordMaskLayer.path = passwordRounded.CGPath;
    self.passwordField.layer.mask = passwordMaskLayer;
    
    // Button corners
    self.connectButton.layer.cornerRadius = 6.0;
    self.fbSignupButton.layer.cornerRadius = 6.0;

    
	//[self.fbSignupButton setBackgroundImage:[[UIImage imageNamed:@"fbButtonBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 6, 38, 5)] forState:UIControlStateNormal];
	//[self.connectButton setBackgroundImage:[[UIImage imageNamed:@"connectButtonBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 6, 38, 5)] forState:UIControlStateNormal];
	
	//[self.usernameField setBackground:[[UIImage imageNamed:@"textFieldTopBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 5, 44, 5)]];
	//[self.passwordField setBackground:[[UIImage imageNamed:@"textFieldBottomBg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 5, 44, 5)]];
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
	[_tokenManager getAccessTokenWithUsername:self.usernameField.text andPassword:self.passwordField.text];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"isJustLogged"]
	   && [object isEqual:_tokenManager]
	   && ((DSTokenManager *)object).isJustLogged)
	{
		NSLog(@"%@", _tokenManager.token.user);
		[_tokenManager removeObserver:self forKeyPath:@"isJustLogged"];
		[_tokenManager removeObserver:self forKeyPath:@"errorString"];
			
		[self.delegate dismissLoginViewController];
	}
    
	if([keyPath isEqualToString:@"errorString"]
	   && [object isEqual:_tokenManager]
	   && ((DSTokenManager *)object).errorString)
	{
		NSLog(@"%d", _tokenManager.statusCode);
		NSLog(@"%@", _tokenManager.errorString);
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
