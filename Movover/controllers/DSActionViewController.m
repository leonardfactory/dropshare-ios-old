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

CGRect CGRectMakeWithNewY(CGRect r, float y)
{
    return CGRectMake(r.origin.x, y, r.size.width, r.size.height);
}

@interface DSActionViewController ()
{
    DSActionManager *actionManager;
    
    UIGestureRecognizer *tapper;
}

@property (strong, nonatomic) DSSocialButtonsBarView *socialButtonsBarView;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImageView *pictureImageView;

@property (strong, nonatomic) UIView *toolbarView;
@property (strong, nonatomic) HPGrowingTextView *commentTextView;

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
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDSActionBaseLeftIndentMargin,
                                                                   kDSActionBaseTopMargin + 11.0,
                                                                   240.0,
                                                                   16.0)];
        // Keyboard
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	}
	return self;
}

- (void) buildView
{
    // Remove translucent navBar. Must be first instruction.
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Some colors configuration
    UIColor *textColor      = [UIColor colorWithWhite:0.15 alpha:1.0];
    UIColor *nameColor      = [UIColor lightGrayColor];
    
    // Comment toolbar & textview
    // Text Input for Comment and toolbar
    self.toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44.0, 320.0, 44.0)];
    self.toolbarView.backgroundColor = [UIColor colorWithRed:228./255. green:234./255. blue:232./255. alpha:1.0];
    
    self.commentTextView                        = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6.0, 4.0, 240.0, 38.0)];
    self.commentTextView.isScrollable           = NO;
    self.commentTextView.contentInset           = UIEdgeInsetsMake(0, 4, 0, 4);
    self.commentTextView.minNumberOfLines       = 1;
    self.commentTextView.maxNumberOfLines       = 6;
    self.commentTextView.returnKeyType          = UIReturnKeySend;
    self.commentTextView.backgroundColor        = [UIColor whiteColor];
    self.commentTextView.layer.cornerRadius     = kDSDefaultCornerRadius + 2.0;
    self.commentTextView.layer.masksToBounds    = YES;
    self.commentTextView.font                   = [UIFont systemFontOfSize:kDSDefaultBigFontSize];
    self.commentTextView.textColor              = [UIColor lightGrayColor];
    self.commentTextView.delegate               = self;
    self.commentTextView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(4, 0, 4, 0);
    self.commentTextView.placeholder            = @"Commenta...";
    
    self.commentTextView.autoresizingMask       = UIViewAutoresizingFlexibleWidth;
    
    [self.toolbarView addSubview:self.commentTextView];
    [self.view insertSubview:self.toolbarView aboveSubview:self.scrollView];
    
    self.toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    // Scrollview top view
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -200, self.scrollView.bounds.size.width, 200)];
    topView.tag     = DSActionViewTagScrollViewTopView;
    [topView setBackgroundColor:[UIColor colorWithRed:228./255. green:234./255. blue:232./255. alpha:1.0]];
    [self.scrollView addSubview:topView];
    
    self.scrollView.autoresizesSubviews = NO;
    self.scrollView.frame   = CGRectMake(0.0, 0.0, 320.0, self.view.bounds.size.height - 44.); // Removing also NavBar + StatusBar
    
    // Handle taps outside keyboard to hide it
    tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = FALSE;
    [self.view addGestureRecognizer:tapper];
    
    // Labels
    self.nameLabel.font         = [UIFont boldSystemFontOfSize:kDSDefaultBigFontSize];
    self.nameLabel.text         = @"";
    self.nameLabel.textColor    = textColor;
    [self.scrollView addSubview:self.nameLabel];
    
    self.usernameLabel					= [[UILabel alloc] initWithFrame:CGRectMake(kDSActionBaseLeftIndentMargin + self.nameLabel.frame.size.width + kDSActionBaseSpacing,
                                                                                    kDSActionBaseTopMargin + 11.0, 100.0, 16.0)];
    self.usernameLabel.backgroundColor	= [UIColor whiteColor]; // +speed
    self.usernameLabel.font				= [UIFont boldSystemFontOfSize:kDSDefaultSmallFontSize];
    self.usernameLabel.textColor		= nameColor;
    self.usernameLabel.text				= @"";
    [self.scrollView addSubview:self.usernameLabel];
    
    // Avatar
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDSActionBaseLeftMargin, kDSActionBaseTopMargin, kDSActionAvatarSize, kDSActionAvatarSize)];
    self.avatarImageView.layer.cornerRadius     = kDSCellAvatarCornerRadius;
    self.avatarImageView.layer.masksToBounds	= YES;
    [self.scrollView addSubview:self.avatarImageView];
    
    // Description
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDSActionBaseLeftMargin,
                                                                      self.avatarImageView.frame.origin.y + self.avatarImageView.frame.size.height + kDSActionWiderSpacing,
                                                                      320.0 - (2*kDSActionBaseLeftMargin),
                                                                      320.0 - (2*kDSActionBaseLeftMargin))];
    self.descriptionLabel.textColor         = textColor;
    self.descriptionLabel.font              = [UIFont systemFontOfSize:kDSDefaultDescriptionFontSize];
    self.descriptionLabel.lineBreakMode     = NSLineBreakByWordWrapping;
    self.descriptionLabel.text              = @"";
    self.descriptionLabel.numberOfLines     = 0; // \n
    self.descriptionLabel.backgroundColor   = [UIColor clearColor];
    [self.scrollView addSubview:self.descriptionLabel];
    
    
    
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
        
        float descriptionLabelHeight  = [_action.text sizeWithFont:[UIFont systemFontOfSize:kDSDefaultDescriptionFontSize]
                                                 constrainedToSize:CGSizeMake(self.descriptionLabel.frame.size.width, FLT_MAX)
                                                     lineBreakMode:NSLineBreakByWordWrapping].height;
        
        self.descriptionLabel.text  = _action.text;
        self.descriptionLabel.frame = CGRectMake(self.descriptionLabel.frame.origin.x,
                                                 self.descriptionLabel.frame.origin.y,
                                                 self.descriptionLabel.frame.size.width,
                                                 descriptionLabelHeight);
    }
    
    if([_action.type isEqualToString:@"capture"])
    {
        NSString *actionImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"action_%@.jpg", _action.identifier]];
        
        self.pictureImageView.frame = CGRectMakeWithNewY(self.pictureImageView.frame,
                                                         self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height + kDSActionWiderSpacing);
        
        [self.pictureImageView setImageWithURL:[NSURL URLWithString:actionImageURL]];
    }
    
    self.socialButtonsBarView.frame = CGRectMakeWithNewY(self.socialButtonsBarView.frame, self.pictureImageView.frame.origin.y + self.pictureImageView.frame.size.height + kDSActionBaseSpacing);
    
    [self.socialButtonsBarView setLikes:_action.statsLike andComments:_action.statsComment andReactions:_action.statsReaction];
    // NSLog(@"Current: %@, main: %@", [NSThread currentThread], [NSThread mainThread]);
    
    [self.navigationItem setTitle:@"Action"];
    
    [self recalculateContentSize];
}

- (void) recalculateContentSize
{
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews)
    {
        if(view.tag != DSActionViewTagScrollViewTopView)
        {
            contentRect = CGRectUnion(contentRect, view.frame);
        }
    }
    self.scrollView.contentSize = contentRect.size;
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

#pragma mark - Dismiss keyboard when tapping outside
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self resignTextView];
}

#pragma mark - Keyboard animation for toolbar
-(void)resignTextView
{
	[self.commentTextView resignFirstResponder];
}

- (void) growingTextView:(HPGrowingTextView *) growingTextView willChangeHeight:(float) height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = self.toolbarView.frame;
    r.size.height   -= diff;
    r.origin.y      += diff;
	self.toolbarView.frame = r;
}

- (void) keyboardWillShow:(NSNotification *) note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration  = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve     = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = self.toolbarView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];

	self.toolbarView.frame = containerFrame;

	[UIView commitAnimations];
}

- (void) keyboardWillHide:(NSNotification *) note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration  = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve     = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = self.toolbarView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	self.toolbarView.frame = containerFrame;
    
	[UIView commitAnimations];
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
