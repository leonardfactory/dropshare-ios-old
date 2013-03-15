//
//  DSCaptureViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 15/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSCaptureViewController.h"

@interface DSCaptureViewController ()

@end

@implementation DSCaptureViewController

- (id) init
{
	self = [super init];
	if(self)
	{
		self.imagePickerController = [[UIImagePickerController alloc] init];
		if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
		{
			self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		}
		else
		{
			self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // @todo aggiungere la possibilità di default di scegliere frai due
		}
		
		self.imagePickerController.allowsEditing = NO;
		self.imagePickerController.delegate = self;
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

#pragma mark - Image picker delegate
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
	
    [[self.imagePickerController parentViewController] dismissModalViewControllerAnimated:YES];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info
{
	
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //UIImage *originalImage;
	
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
		
        //self.imageToBePosted = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
		
		// Save the new image (original or edited) to the Camera Roll
        //UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil , nil);
    }
	
    [self dismissModalViewControllerAnimated: YES];
}

@end
