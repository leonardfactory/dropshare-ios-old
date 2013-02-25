//
//  DSDiscoverViewController.h
//  Shabaka
//
//  Created by Leonardo Ascione on 24/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SidePanel.h"

typedef enum _DSViewAnimationState
{
	DSViewAnimationStateNone = 0,
	DSViewAnimationStateShow,
	DSViewAnimationStateHide,
	DSViewAnimationStateResizeSmall,
	DSViewAnimationStateResizeFull
} DSViewAnimationState;

typedef struct
{
	DSViewAnimationState animation;
	CGRect visibleFrame;
} ViewState;

@interface DSDiscoverViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;

@end
