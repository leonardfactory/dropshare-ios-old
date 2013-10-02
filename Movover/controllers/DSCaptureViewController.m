//
//  DSCaptureViewController.m
//  Movover
//
//  Created by Leonardo Ascione on 15/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSCaptureViewController.h"
#import "DSAddViewController.h"

@interface DSCaptureViewController ()

@end

@implementation DSCaptureViewController

- (id) init
{
	self = [super init];
	if(self)
	{
		self.imagePickerController = [[UIImagePickerController alloc] init];
		self.view.frame = self.imagePickerController.view.frame;
		
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
    [[self.imagePickerController.navigationController parentViewController] dismissModalViewControllerAnimated:YES];
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info
{
	
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //UIImage *originalImage;
	
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo)
	{
		UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"]
													 bundle:[NSBundle mainBundle]];
		
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
		
		[self.imagePickerController setNavigationBarHidden:NO animated:YES];
		
		DSAddViewController *addViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"addViewController"];
		[addViewController postImageFromCapture:(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage]];
		
		[self.imagePickerController pushViewController:addViewController animated:YES];
        //self.imageToBePosted = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
		
		// Save the new image (original or edited) to the Camera Roll
        //UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil , nil);
    }
	
    //[self dismissModalViewControllerAnimated: YES];
}

@end
