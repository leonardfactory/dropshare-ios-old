//
//  UIViewController+SidePanel.m
//  Ramses
//
//  Created by Leonardo on 23/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "UIViewController+SidePanel.h"

@implementation UIViewController (SidePanel)

- (DSSidePanelController *) sidePanelController
{
    UIViewController *iter = self.parentViewController;
    while (iter)
    {
        if ([iter isKindOfClass:[DSSidePanelController class]])
		{
            return (DSSidePanelController *) iter;
        }
		else if (iter.parentViewController && iter.parentViewController != iter)
		{
            iter = iter.parentViewController;
        }
		else
		{
            iter = nil;
        }
    }
    return nil;
}

@end
