//
//  DSAddButton.h
//  Movover
//
//  Created by Leonardo Ascione on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
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

@property (strong, nonatomic) NSString *actionCalled;

- (id)initWithFrame:(CGRect)frame andActions:(NSArray *)actions andSuperFrame:(CGRect) superFrame;

@end
