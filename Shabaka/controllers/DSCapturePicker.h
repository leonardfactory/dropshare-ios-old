//
//  DSCapturePicker.h
//  Shabaka
//
//  Created by Leonardo Ascione on 15/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSCapturePicker : NSObject <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) UIViewController *originController;
@property (strong, nonatomic) UIImagePickerController *pickerController;

- (id) initWithController:(UIViewController *) controller;
- (void) showCapture;

@end
