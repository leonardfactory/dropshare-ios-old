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

#import "DSActionManager.h"
#import "DSAction.h"
#import "DSUserManager.h"
#import "DSUser.h"

#import "DSSocialButtonsBarView.h"
#import "UIImageView+AFNetworking.h"

@interface DSActionViewController ()
{
    DSActionManager *actionManager;
}

@property (strong, nonatomic) DSSocialButtonsBarView *socialButtonsBarView;
@property (strong, nonatomic) UILabel *usernameLabel;

@end

@implementation DSActionViewController

@synthesize action = _action;

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
        // Model
        actionManager = [DSActionManager sharedManager];
        
        // hi!
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDSActionBaseLeftIndentMargin, kDSActionBaseTopMargin + 4.0, 240.0, 16.0)];
	}
	return self;
}

- (void) buildView
{
    // Some colors configuration
    UIColor *textColor      = [UIColor colorWithWhite:0.15 alpha:1.0];
    UIColor *nameColor      = [UIColor lightGrayColor];
    
    // Remove translucent navBar
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.nameLabel.font         = [UIFont boldSystemFontOfSize:kDSDefaultBigFontSize];
    self.nameLabel.text         = @"Name";
    self.nameLabel.textColor    = textColor;
    [self.scrollView addSubview:self.nameLabel];
    
    self.usernameLabel					= [[UILabel alloc] initWithFrame:CGRectMake(kDSActionBaseLeftIndentMargin + self.nameLabel.frame.size.width + kDSActionBaseSpacing,
                                                                                    kDSActionBaseTopMargin + 4.0, 100.0, 16.0)];
    self.usernameLabel.backgroundColor	= [UIColor whiteColor]; // +speed
    self.usernameLabel.font				= [UIFont boldSystemFontOfSize:kDSDefaultSmallFontSize];
    self.usernameLabel.textColor		= nameColor;
    self.usernameLabel.text				= @"@username";
    [self.scrollView addSubview:self.usernameLabel];
    
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
    
    // Social buttons bar
    self.socialButtonsBarView = [[DSSocialButtonsBarView alloc] initWithFrame:CGRectMake(kDSActionBaseLeftIndentMargin,
                                                                                         self.pictureImageView.frame.origin.y + self.pictureImageView.frame.size.height + kDSActionBaseSpacing,
                                                                                         200.0,
                                                                                         kDSCellSocialBarHeight)];
    [self.scrollView addSubview:self.socialButtonsBarView];
    
    // Like style & action
    [self.socialButtonsBarView applyStyleForLike:[_action.like boolValue]];
    [self.socialButtonsBarView.likeButton addTarget:self action:@selector(likeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void) updateView
{
    if(_action.subjectId && [_action.subjectEntity isEqualToString:@"User"])
    {
        DSUser *user = [[DSUserManager sharedManager] userWithId:_action.subjectId];
        self.nameLabel.text     = user.completeName;
        self.nameLabel.frame    = CGRectMake(self.nameLabel.frame.origin.x,
                                             self.nameLabel.frame.origin.y,
                                             [user.completeName sizeWithFont:[UIFont boldSystemFontOfSize:kDSDefaultBigFontSize]].width,
                                             self.nameLabel.frame.size.height);
        
        self.usernameLabel.text     = [NSString stringWithFormat:@"@%@", user.username];
        self.usernameLabel.frame    = CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + kDSActionBaseSpacing / 2.,
                                                 self.usernameLabel.frame.origin.y,
                                                 [self.usernameLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:kDSDefaultSmallFontSize]].width,
                                                 self.usernameLabel.frame.size.height);
        
        NSString *avatarImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"user_avatar_%@.jpg", user.identifier]];
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:avatarImageURL]];
        //[self.avatarImageView setNeedsDisplay];
    }
    
    if([_action.type isEqualToString:@"capture"])
    {
        NSString *actionImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"action_%@.jpg", _action.identifier]];
        [self.pictureImageView setImageWithURL:[NSURL URLWithString:actionImageURL]];
    }
    
    [self.socialButtonsBarView setLikes:_action.statsLike andComments:_action.statsComment andReactions:_action.statsReaction];
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

#pragma mark - Like action
- (void) likeButtonPressed
{
    if([self.socialButtonsBarView canPerformLike])
    {
        if([_action.like boolValue] == YES) {
            // unlike
            [actionManager unlikeAction:_action];
            [self.socialButtonsBarView animateUnlike];
        }
        else {
            // like
            [actionManager likeAction:_action]; // @todo only actions?
            [self.socialButtonsBarView animateLike];
        }
    }
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
