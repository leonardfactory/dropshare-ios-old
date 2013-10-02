//
//  DSCaptureViewController.h
//  Movover
//
//  Created by Leonardo Ascione on 15/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSCaptureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@end
