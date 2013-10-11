//
//  DSAddViewController.h
//  Movover
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HPGrowingTextView.h>

@protocol DSAddViewControllerDelegate

@required
- (void) didAddPhoto;

@end

@interface DSAddViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, HPGrowingTextViewDelegate>

@property (nonatomic, assign) id <DSAddViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString* type;

- (void) postImageFromCapture:(UIImage *)image;

@end
