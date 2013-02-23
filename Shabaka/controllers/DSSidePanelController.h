//
//  MainSidePanelController.h
//  Dropshare
//
//  Created by Leonardo Ascione on 04/02/13.
//  Copyright (c) 2013 Leonardo Ascione. All rights reserved.
//

#import "JASidePanelController.h"

// Protocol to handle multiple view controllers
@protocol SidePanelContainer

@property (strong, nonatomic) NSMutableDictionary *loadedViewControllers;
@property (strong, nonatomic) NSString *selectedViewControllerName;

- (void) setViewControllers:(NSDictionary *)objects whereSelectedIs:(NSString *)name;
- (void) showViewController:(NSString *)identifier;
- (UIViewController *)selectedViewController;

@end

// Interface for MainSidePanelController
@interface DSSidePanelController : JASidePanelController <SidePanelContainer>

@end
