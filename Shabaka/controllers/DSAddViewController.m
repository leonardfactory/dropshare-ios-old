//
//  DSAddViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSAddViewController.h"

@interface DSAddViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) UIImage *imageToBePosted;

@end

@implementation DSAddViewController 

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		//...
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.textView.contentInset = UIEdgeInsetsMake(0,-8,0,0);
	
	[self.textView becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	if([self.type isEqualToString:@"actionCapture"])
	{
		[self showCamera];
	}
}

#pragma mark - Camera handling
- (void) showCamera
{
	UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
	
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    //use default: cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
	
    cameraUI.delegate = self;
	
    [self presentModalViewController:cameraUI animated:NO];
}

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
	
    [self dismissModalViewControllerAnimated:YES];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info
{
	
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //UIImage *originalImage;
	
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {

        self.imageToBePosted = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
		
		// Save the new image (original or edited) to the Camera Roll
        //UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil , nil);
    }
	
    [self dismissModalViewControllerAnimated: YES];
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
