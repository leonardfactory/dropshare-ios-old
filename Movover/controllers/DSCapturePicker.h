//
//  DSCapturePicker.h
//  Movover
//
//  Created by Leonardo Ascione on 15/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSAddViewController.h"

@interface DSCapturePicker : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate, DSAddViewControllerDelegate>

@property (weak, nonatomic) UIViewController *originController;
@property (strong, nonatomic) UIImagePickerController *pickerController;

- (id) initWithController:(UIViewController *) controller;
- (void) showCapture;
- (void) didAddPhoto;

@end
