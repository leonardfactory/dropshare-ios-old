//
//  DSCapturePicker.m
//  Movover
//
//  Created by Leonardo Ascione on 15/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSCapturePicker.h"
#import "DSAddViewController.h"

@implementation DSCapturePicker

@synthesize originController = _originController;
@synthesize pickerController = _pickerController;

- (id) initWithController:(UIViewController *) controller 
{
	self = [super init];
	if(self)
	{
		_originController = controller;
		
		_pickerController = [[UIImagePickerController alloc] init];
		if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
		{
			_pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		}
		else
		{
			_pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; // @todo aggiungere la possibilità di default di scegliere frai due
		}
		
		_pickerController.allowsEditing = NO;
		_pickerController.delegate = self;
	}
	return self;
}

- (void) showCapture
{
	[self.originController presentModalViewController:_pickerController animated:YES];
}

#pragma mark - ImagePicker delegate
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    [self.originController dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];

    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
	{
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
		
		UIStoryboard *mainStoryboard = self.originController.storyboard;
		
		DSAddViewController *addViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addViewController"];
		[addViewController postImageFromCapture:(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage]];
		
		[picker setNavigationBarHidden:NO animated:YES];
		[picker pushViewController:addViewController animated:YES];
        //self.imageToBePosted = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
		
		// Save the new image (original or edited) to the Camera Roll
        //UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil , nil);
    }
}
@end
