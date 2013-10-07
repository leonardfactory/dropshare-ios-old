//
//  DSAddViewController.m
//  Movover
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DSAddViewController.h"
#import "DSTokenManager.h"
#import "DSActionManager.h"

#import "InterfaceConstants.h"
#import "UIImage+Resize.h"
#import "UIImageView+AFNetworking.h"

#import "DSCloudinary.h"

@interface DSAddViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
//@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) HPGrowingTextView *textView;

@property (strong, nonatomic) UIImage *imageToBePosted;
@property (strong, nonatomic) UIImageView *imageToBePostedView;
@property (strong, nonatomic) DSTokenManager *tokenManager;
@property (strong, nonatomic) DSActionManager *actionManager;

@end

@implementation DSAddViewController

@synthesize tokenManager = _tokenManager;
@synthesize actionManager = _actionManager;

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		_tokenManager = [[DSTokenManager alloc] init];
        _actionManager = [[DSActionManager alloc] init];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWasShown:)
													 name:UIKeyboardDidShowNotification object:nil];
	}
	return self;
}

- (void) buildView
{
    // Remove translucent
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Add Button on the navigation Bar
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																				 target:self
																				 action:@selector(addPhoto)];
	self.navigationItem.rightBarButtonItem = addButton;
	
	//[self.avatarImageView setImageWithURL:[NSURL URLWithString:[DSImageUrl getAvatarUrlFromUserId:_profileManager.profile.user.identifier]]];
    NSString *avatarImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"user_avatar_%@.jpg", _tokenManager.token.user.identifier]];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:avatarImageURL]];
	self.avatarImageView.layer.cornerRadius     = kDSCellAvatarCornerRadius;
    self.avatarImageView.layer.masksToBounds    = YES;
	
    // Text view
	//self.textView.contentInset = UIEdgeInsetsZero;
	//[self.textView becomeFirstResponder];
    self.textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(66, 74, 244, 40)];
    self.textView.isScrollable = NO;
    self.textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	self.textView.minNumberOfLines = 1;
	self.textView.maxNumberOfLines = 6;
    // you can also set the maximum height in points with maxHeight
    // textView.maxHeight = 200.0f;
	self.textView.returnKeyType = UIReturnKeyGo; //just as an example
	self.textView.font = [UIFont systemFontOfSize:15.0f];
	self.textView.delegate = self;
    self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    //self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.placeholder = @"Cosa sta succedendo?";
    
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.textView becomeFirstResponder];
    
    [self.view addSubview:self.textView];
}

- (void) growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    //float diff = (growingTextView.frame.size.height - height);
    
	/* CGRect r = self.view.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	containerView.frame = r; */
}

- (void) postImageFromCapture:(UIImage *)image
{
	float squareSize = MIN(MIN(image.size.height, image.size.width), 1024);
	self.imageToBePosted = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit
													   bounds:CGSizeMake(squareSize, squareSize)
										 interpolationQuality:kCGInterpolationHigh];
	
	self.imageToBePostedView = [[UIImageView alloc] initWithImage:[self.imageToBePosted thumbnailImage:104.0
																					 transparentBorder:0
																						  cornerRadius:0
																				  interpolationQuality:kCGInterpolationHigh]];
	self.imageToBePostedView.frame = CGRectMake(kDSCellAvatarLeftMargin,
												self.view.bounds.size.height - 104.0,
												104.0,
												104.0);
	self.imageToBePostedView.layer.cornerRadius = kDSDefaultCornerRadius;
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
                                     self.textView.frame.size.width,
									 self.view.bounds.size.height - kbSize.height);
}

- (void) addPhoto
{
	//[_dropManager captureWithImage:self.imageToBePosted WithText:self.textView.text];
    [_actionManager captureWithImage:self.imageToBePosted andText:self.textView.text];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
	
	[self buildView];
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
