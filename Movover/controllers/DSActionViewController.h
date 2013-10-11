//
//  DSActionViewController.h
//  Movover
//
//  Created by Leonardo on 10/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceConstants.h"

#import "DSAction.h"
#import "DSUser.h"

@interface DSActionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImageView *pictureImageView;

@property (strong, nonatomic) DSAction *action;

- (void) buildWithAction:(DSAction *)action;

@end
