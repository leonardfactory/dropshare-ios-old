//
//  DSAddViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSAddViewController.h"
#import "DSProfileManager.h"

#import "InterfaceConstants.h"
#import "UIImage+Resize.h"

@interface DSAddViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) UIImage *imageToBePosted;
@property (strong, nonatomic) DSProfileManager *profileManager;

@end

@implementation DSAddViewController

@synthesize profileManager = _profileManager;

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		_profileManager = [[DSProfileManager alloc] init]; // @todo
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// @todo
	[self.avatarImageView setImage:[[UIImage imageNamed:@"avatar.png"] thumbnailImage:48
																	transparentBorder:0
																		 cornerRadius:kDSCellAvatarCornerRadius
																 interpolationQuality:kCGInterpolationHigh]];
	
	self.textView.contentInset = UIEdgeInsetsMake(0,-8,0,0);
	[self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setAvatarImageView:nil];
	[self setTextView:nil];
	[super viewDidUnload];
}
@end
