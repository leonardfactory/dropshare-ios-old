//
//  UIViewController+SidePanel.h
//  Ramses
//
//  Created by Leonardo on 23/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSSidePanelController.h"

@interface UIViewController (SidePanel)

@property (nonatomic, weak, readonly) DSSidePanelController *sidePanelController;

@end
