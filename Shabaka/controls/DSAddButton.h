//
//  DSAddButton.h
//  Shabaka
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSActionButton.h"
#import "InterfaceConstants.h"

typedef enum _DSAddButtonState
{
	DSAddButtonStateClosed = 0,
	DSAddButtonStateOpening,
	DSAddButtonStateOpened,
	DSAddButtonStateClosing
} DSAddButtonState;

@interface DSAddButton : UIButton

- (id)initWithFrame:(CGRect)frame andActions:(NSArray *)actions;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
