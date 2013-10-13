//
//  DSActionViewController.h
//  Movover
//
//  Created by Leonardo on 10/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterfaceConstants.h"

#import <HPGrowingTextView.h>

#import "DSAction.h"
#import "DSUser.h"

typedef enum _DSActionViewTag
{
	DSActionViewTagScrollViewTopView = 1000
} DSActionViewTag;

CGRect CGRectMakeWithNewY(CGRect r, float y);

@interface DSActionViewController : UIViewController <HPGrowingTextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) DSAction *action;

- (void) buildWithAction:(DSAction *)action;

- (void) resignTextView;
- (void) growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height;

@end
