//
//  DSDiscoverViewController.h
//  Shabaka
//
//  Created by Leonardo Ascione on 24/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "DSJournalSimpleDropCell.h"
#import "UIViewController+SidePanel.h"
#import "DSViewPager.h"

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

@interface DSDiscoverViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DSViewPagerDataSource>

@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;

@end
