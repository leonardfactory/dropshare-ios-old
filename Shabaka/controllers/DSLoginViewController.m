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
		profileManager = [[DSProfileManager alloc] init];
		
		[profileManager.domain addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:nil];
		[profileManager.domain addObserver:self forKeyPath:@"error" options:NSKeyValueObservingOptionNew context:nil];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.fbSignupButton setBackgroundImage:[[self.fbSignupButton backgroundImageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 6, 40, 6)] forState:UIControlStateNormal];
	[self.connectButton setBackgroundImage:[[self.connectButton backgroundImageForState:UIControlStateNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 6, 40, 6)] forState:UIControlStateNormal];

	[self.usernameField setBackground:[self.usernameField.background resizableImageWithCapInsets:UIEdgeInsetsMake(1, 6, 44, 6)]];
	[self.passwordField setBackground:[self.passwordField.background resizableImageWithCapInsets:UIEdgeInsetsMake(1, 6, 44, 6)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
- (void) loginUser:(id) sender
{
	
	[profileManager loginWithUsername:self.usernameField.text withPassword:self.passwordField.text];
	
	// make login with data adapter
	void (^loginCompleted)(bool, User*) = ^(bool logged, User *user)
	{
		if(logged)
		{
			self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
			[self dismissModalViewControllerAnimated:NO];
		}
		else
		{
			//...
		}
	};
	
	void (^loginFailed)(NSString*) = ^(NSString *errorMessage)
	{
		[self.passwordField setText:@""];
		// Show errror message in a label
	};
	
	// Test code
	
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"user"] && [object isKindOfClass:[ProfileDomain class]])
	{
		if([profileManager isLogged])
		{
			self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
			[self dismissModalViewControllerAnimated:NO];
		}
	}
	
	if([keyPath isEqualToString:@"error"] && [object isKindOfClass:[ProfileDomain class]])
	{
		NSLog(@"error");
	}
}

- (void) signUpWithFacebook:(id) sender
{
	
}

- (IBAction)connectButtonPressed:(id) sender
{
	[self loginUser:sender];
}

- (IBAction)signupButtonPressed:(id) sender
{
	[self signUpWithFacebook:sender];
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
