//
//  DSSocialButtonsBarView.m
//  Movover
//
//  Created by Leonardo on 11/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSSocialButtonsBarView.h"

@interface DSSocialButtonsBarView ()
{
    UIColor *normalColor;
    UIColor *highlightedColor;
    UIFont *font;
    
    FIIcon *likeIcon;
    FIIcon *commentIcon;
    
    DSButtonAnimationState likeAnimationState;
}

@end

@implementation DSSocialButtonsBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        font                            = [UIFont boldSystemFontOfSize:kDSDefaultFontSize];
		normalColor                     = [UIColor colorWithRed:0./255. green:186./255. blue:115./255. alpha:1.0];
        UIColor *socialBackgroundColor  = [UIColor colorWithRed:245./255. green:245./255. blue:245./255. alpha:1.0];
		
		// Like Button
        likeAnimationState      = DSButtonAnimationNone;
        
		likeIcon                = [FIEntypoIcon heartIcon];
		self.likeButton			= [UIButton buttonWithType:UIButtonTypeCustom];
        self.likeButton.tag     = 1;
		self.likeButton.frame	= CGRectMake(0.0,
											 kDSCellSocialButtonTopMargin,
											 kDSCellSocialButtonWidth,
											 kDSCellSocialButtonHeight);
        
        self.likeButton.layer.cornerRadius = kDSCellCornerRadius;
        
        [self.likeButton setBackgroundColor:socialBackgroundColor];
		[self.likeButton setTitle:@"2" forState:UIControlStateNormal];
		[self.likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 6.0, 0.0, 0.0)];
		[self.likeButton.titleLabel setFont:font];
		[self.likeButton setTitleColor:normalColor forState:UIControlStateNormal];
		[self.likeButton setImage:[likeIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize)
                                                      color:normalColor]
                         forState:UIControlStateNormal];
		
		[self addSubview:self.likeButton];
		
        // Comment Button
        commentIcon                 = [FIEntypoIcon commentIcon];
		self.commentButton			= [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentButton.tag      = 2;
		self.commentButton.frame	= CGRectMake(kDSCellSocialButtonWidth + kDSCellSocialBarSpacing,
												 kDSCellSocialButtonTopMargin,
												 kDSCellSocialButtonWidth,
												 kDSCellSocialButtonHeight);
        
        self.commentButton.layer.cornerRadius = kDSCellCornerRadius;
        
        [self.commentButton setBackgroundColor:socialBackgroundColor];
		[self.commentButton setTitle:@"4" forState:UIControlStateNormal];
		[self.commentButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 0.0)];
		[self.commentButton.titleLabel setFont:font];
		[self.commentButton setTitleColor:normalColor forState:UIControlStateNormal];
        [self.commentButton setImage:[commentIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize)
                                                            color:normalColor]
                            forState:UIControlStateNormal];
		
		[self addSubview:self.commentButton];
    }
    return self;
}

/**
 * Changes buttons width based on text size
 */
- (void) updateCountForButton:(UIButton *)button withNumber:(NSNumber *)number
{
    [self updateCountForButton:button withNumber:number animating:YES];
}

- (void) updateCountForButton:(UIButton *)button withNumber:(NSNumber *)number animating:(BOOL) animating
{
    NSUInteger oldNumber = [button.currentTitle intValue];
    NSUInteger newNumber = [number intValue];
    
    NSString *oldNumberString = [NSString stringWithFormat:@"%u", oldNumber];
    NSString *newNumberString = [NSString stringWithFormat:@"%u", newNumber];
    
    BOOL shouldAnimate =    (oldNumberString.length != newNumberString.length) ||
    ((oldNumber == 0 || newNumber == 0) && newNumber != oldNumber);
    
    // Animate only if affinity transformation is the Identity
    shouldAnimate = shouldAnimate && CGAffineTransformIsIdentity(button.transform);
    
    // Animate only if requested
    shouldAnimate = shouldAnimate && animating;
    
    NSString *newTitle = newNumber == 0 ? @"" : newNumberString;
    
    float oldTextWidth = [button.currentTitle sizeWithFont:[UIFont boldSystemFontOfSize:kDSDefaultFontSize] constrainedToSize:CGSizeMake(100.0, 0.0)].width;
    float newTextWidth = [newTitle sizeWithFont:[UIFont boldSystemFontOfSize:kDSDefaultFontSize] constrainedToSize:CGSizeMake(100.0, 0.0)].width;
    float diff = newTextWidth - oldTextWidth;
    
    float animationDuration = shouldAnimate ? 0.2f : 0.0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        // Change title
        [button setTitle:newTitle forState:UIControlStateNormal];
        
        // Update frame size
        CGRect bounds = button.bounds;
        CGRect newBounds = CGRectMake(bounds.origin.x, bounds.origin.y, newTextWidth + kDSCellSocialButtonBaseWidth, bounds.size.height);
        button.bounds = newBounds;
        
        // Update other buttons on the right
        NSInteger tag = button.tag + 1;
        UIButton *nextButton;
        while((nextButton = (UIButton *)[button.superview viewWithTag:tag]))
        {
            CGPoint center = nextButton.center;
            nextButton.center = CGPointMake(center.x + diff, center.y);
            tag++;
        }
    }];
}

- (BOOL) canPerformLike
{
    return likeAnimationState == DSButtonAnimationNone;
}

/**
 * Setta likes, comments e reactions
 */
- (void) setLikes:(NSNumber *) likes andComments:(NSNumber *) comments andReactions:(NSNumber *) reactions
{
    //[self.likeButton setTitle:[likes stringValue] forState:UIControlStateNormal];
    //[self.commentButton setTitle:[comments stringValue] forState:UIControlStateNormal];
    
    [self updateCountForButton:self.likeButton withNumber:likes];
    [self updateCountForButton:self.commentButton withNumber:comments];
}

/**
 * Changes only buttons styles, without changing text.
 */
- (void) applyStyleForLike:(BOOL) like
{
    if(like) {
        [self applyLikeStyle];
    }
    else {
        [self applyUnlikeStyle];
    }
}

- (void) applyUnlikeStyle
{
    UIColor *likeColor = [UIColor colorWithRed:0./255. green:186./255. blue:115./255. alpha:1.0];
    [self.likeButton setImage:[likeIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize) color:likeColor] forState:UIControlStateNormal];
    [self.likeButton setTitleColor:likeColor forState:UIControlStateNormal];
}

- (void) applyLikeStyle
{
    UIColor *likeColor = [UIColor colorWithRed:200./255. green:44./255. blue:44./255. alpha:1.0];
    [self.likeButton setImage:[likeIcon imageWithBounds:CGRectMake(0.0, 0.0, kDSCellSocialButtonIconSize, kDSCellSocialButtonIconSize) color:likeColor] forState:UIControlStateNormal];
    [self.likeButton setTitleColor:likeColor forState:UIControlStateNormal];
}

/**
 * Animazione del like e dell'unlike
 */
- (void) animateUnlike
{
    if(likeAnimationState == DSButtonAnimationNone)
    {
        likeAnimationState = DSButtonAnimationUnlike;
        
        [self applyUnlikeStyle];
        
        [UIView animateWithDuration:0.2f
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             // Fade out, but not completely
                             self.likeButton.imageView.alpha = 0.3;
                             
                             self.likeButton.imageView.transform = CGAffineTransformMakeScale(3.0, 3.0); // CGAffineTransformScale(self.likeButton.imageView.transform, 3, 3);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2f
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.likeButton.imageView.alpha = 1.0;
                                                  self.likeButton.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0); //CGAffineTransformScale(self.likeButton.imageView.transform, 1, 1);
                                              }
                                              completion:^(BOOL finished) {
                                                  self.likeButton.imageView.transform = CGAffineTransformIdentity;
                                                  [self updateCountForButton:self.likeButton withNumber:[NSNumber numberWithInt:[self.likeButton.currentTitle intValue] - 1]];
                                                  likeAnimationState = DSButtonAnimationNone;
                                              }];
                         }];
    }
    /*else {
     [self updateCountForButton:self.likeButton withNumber:[NSNumber numberWithInt:[self.likeButton.currentTitle intValue] - 1] animating:false];
     }*/
}

/**
 * Animazione dell'unlike
 */
- (void) animateLike
{
    if(likeAnimationState == DSButtonAnimationNone)
    {
        likeAnimationState = DSButtonAnimationLike;
        
        [self applyLikeStyle];
        
        [UIView animateWithDuration:0.2f
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             // Fade out, but not completely
                             self.likeButton.imageView.alpha = 0.3;
                             
                             self.likeButton.imageView.transform = CGAffineTransformMakeScale(3.0, 3.0); // CGAffineTransformScale(self.likeButton.imageView.transform, 3, 3);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2f
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.likeButton.imageView.alpha = 1.0;
                                                  self.likeButton.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0); //CGAffineTransformScale(self.likeButton.imageView.transform, 1, 1);
                                              }
                                              completion:^(BOOL finished) {
                                                  self.likeButton.imageView.transform = CGAffineTransformIdentity;
                                                  [self updateCountForButton:self.likeButton withNumber:[NSNumber numberWithInt:[self.likeButton.currentTitle intValue] + 1]];
                                                  likeAnimationState = DSButtonAnimationNone;
                                              }];
                         }];
    }
}

@end
