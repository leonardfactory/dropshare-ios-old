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
	DSDataAdapter *dataAdapter;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation DSLoginViewController

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		dataAdapter = [[DSDataAdapter alloc] init];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
- (void) loginUser:(id) sender
{
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
	[super viewDidUnload];
}
@end
