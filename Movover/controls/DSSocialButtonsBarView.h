//
//  DSSocialButtonsBarView.h
//  Movover
//
//  Created by Leonardo on 11/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FontasticIcons.h>

#import "InterfaceConstants.h"

typedef enum _DSButtonAnimationState
{
	DSButtonAnimationNone = 0,
	DSButtonAnimationUnlike,
    DSButtonAnimationLike
} DSButtonAnimationState;

typedef enum _DSButtonSocialTag
{
	DSButtonSocialLike = 10,
	DSButtonSocialComment,
    DSButtonSocialReaction
} DSButtonSocialTag;

@interface DSSocialButtonsBarView : UIView

@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *commentButton;
//@property (strong, nonatomic) UIButton *reactionButton;

- (void) updateCountForButton:(UIButton *)button withNumber:(NSNumber *)number animating:(BOOL) animating;
- (void) setLikes:(NSNumber *) likes andComments:(NSNumber *) comments andReactions:(NSNumber *) reactions;

- (BOOL) canPerformLike;

- (void) applyStyleForLike:(BOOL) like;
- (void) applyUnlikeStyle;
- (void) applyLikeStyle;

- (void) animateUnlike;
- (void) animateLike;

@end
