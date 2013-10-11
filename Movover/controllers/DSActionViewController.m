//
//  DSActionViewController.m
//  Movover
//
//  Created by Leonardo on 10/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DSActionViewController.h"

#import "DSDataAdapter.h"
#import "DSCloudinary.h"

#import "DSUserManager.h"
#import "DSUser.h"

#import "UIImageView+AFNetworking.h"

@interface DSActionViewController ()

@end

@implementation DSActionViewController

@synthesize action = _action;

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
        // hi!
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDSActionBaseLeftMargin + kDSCellAvatarSize + kDSActionBaseSpacing, kDSActionBaseTopMargin, 240.0, 16.0)];
	}
	return self;
}

- (void) buildView
{
    // Remove translucent navBar
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.nameLabel.font = [UIFont boldSystemFontOfSize:kDSDefaultBigFontSize];
    self.nameLabel.text = @"Username";
    [self.scrollView addSubview:self.nameLabel];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDSActionBaseLeftMargin, kDSActionBaseTopMargin, kDSCellAvatarSize, kDSCellAvatarSize)];
    self.avatarImageView.layer.cornerRadius     = kDSCellAvatarCornerRadius;
    self.avatarImageView.layer.masksToBounds	= YES;
    [self.scrollView addSubview:self.avatarImageView];
    
    self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDSActionBaseLeftMargin,
                                                                          self.avatarImageView.frame.origin.y + self.avatarImageView.frame.size.height + kDSActionBaseSpacing,
                                                                          320.0 - (2*kDSActionBaseLeftMargin),
                                                                          320.0 - (2*kDSActionBaseLeftMargin))];
    self.pictureImageView.layer.cornerRadius    = kDSCellAvatarCornerRadius;
    self.pictureImageView.layer.masksToBounds	= YES;
    [self.scrollView addSubview:self.pictureImageView];
}

- (void) updateView
{
    if(_action.subjectId && [_action.subjectEntity isEqualToString:@"User"])
    {
        DSUser *user = [[DSUserManager sharedManager] userWithId:_action.subjectId];
        self.nameLabel.text     = user.completeName;
        self.nameLabel.frame    = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, 140.0, self.nameLabel.frame.size.height);
        [self.nameLabel setNeedsDisplay];
        
        NSString *avatarImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"user_avatar_%@.jpg", user.identifier]];
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:avatarImageURL]];
        [self.avatarImageView setNeedsDisplay];
    }
    
    if([_action.type isEqualToString:@"capture"])
    {
        NSString *actionImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"action_%@.jpg", _action.identifier]];
        [self.pictureImageView setImageWithURL:[NSURL URLWithString:actionImageURL]];
    }
    
    // NSLog(@"Current: %@, main: %@", [NSThread currentThread], [NSThread mainThread]);
    
    [self.navigationItem setTitle:_action.text];
    [self.scrollView setNeedsDisplay];
}

- (void) buildWithAction:(DSAction *)action
{
    _action = action;
    [_action addObserver:self forKeyPath:@"subjectId" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self buildView];
    [self updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Listening to changes for Model

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"subjectId"] &&
       [object isKindOfClass:[DSAction class]])
    {
        // need to refresh view
        [self performSelectorOnMainThread:@selector(updateView) withObject:nil waitUntilDone:NO];
    }
}

@end
