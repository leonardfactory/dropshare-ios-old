//
//  DSDiscoverViewController.h
//  Shabaka
//
//  Created by Leonardo Ascione on 24/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SidePanel.h"

typedef enum _DSTableViewAnimationState
{
	DSTableViewAnimationStateNone = 0,
	DSTableViewAnimationStateShow,
	DSTableViewAnimationStateHide
} DSTableViewAnimationState;

@interface DSDiscoverViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;

@end
