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
#import "UIImageView+AFNetworking.h"

#import "DSImageUrl.h"

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
		_profileManager = [[DSProfileManager alloc] init];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.avatarImageView setImageWithURL:[NSURL URLWithString:[DSImageUrl getAvatarUrlFromUserId:_profileManager.profile.user.identifier]]];
	
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
