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
@property (strong, nonatomic) UIImageView *imageToBePostedView;
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
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWasShown:)
													 name:UIKeyboardDidShowNotification object:nil];
	}
	return self;
}

- (void) postImageFromCapture:(UIImage *)image
{
	float squareSize = MIN(MIN(image.size.height, image.size.width), 1024);
	self.imageToBePosted = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit
													   bounds:CGSizeMake(squareSize, squareSize)
										 interpolationQuality:kCGInterpolationHigh];
	
	self.imageToBePostedView = [[UIImageView alloc] initWithImage:[self.imageToBePosted thumbnailImage:104.0
																					 transparentBorder:0
																						  cornerRadius:3
																				  interpolationQuality:kCGInterpolationHigh]];
	self.imageToBePostedView.frame = CGRectMake(kDSCellAvatarLeftMargin,
												self.view.bounds.size.height - 104.0,
												104.0,
												104.0);
	[self.view addSubview:self.imageToBePostedView];
}
												
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
	self.imageToBePostedView.frame = CGRectMake(kDSCellAvatarLeftMargin,
												self.view.frame.size.height - kbSize.height - 4.0 - 104.0,
												104.0,
												104.0);
	
	self.textView.frame = CGRectMake(self.textView.frame.origin.x,
									 self.textView.frame.origin.y,
									 self.view.bounds.size.height - kbSize.height,
									 self.textView.frame.size.width);
}

- (void) viewDidLoad
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

- (void)viewDidUnload
{
	[self setAvatarImageView:nil];
	[self setTextView:nil];
	[super viewDidUnload];
}
@end
