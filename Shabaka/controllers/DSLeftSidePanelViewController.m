//
//  DSLeftSidePanelViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSSidePanelController.h"
#import "UIViewController+SidePanel.h"

#import "DSLeftSidePanelViewController.h"

@interface DSLeftSidePanelViewController ()

@property (weak, nonatomic) IBOutlet UIButton *menuButtonDiscover;

@end

@implementation DSLeftSidePanelViewController

// @todo: aggiungere initWithCoder

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Codice per personalizzare l'onclick background
	UIImage *menuButtonBgPressedPattern = [[UIImage imageNamed:@"menuButtonBgPressed"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    [self.menuButtonDiscover setBackgroundImage:menuButtonBgPressedPattern forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setMenuButtonDiscover:nil];
	[super viewDidUnload];
}

- (IBAction)menuButtonDiscoverTouched:(id)sender
{
	[self.sidePanelController showViewController:@"map"];
}

- (IBAction)loginButtonTouched:(id)sender
{
	[self.sidePanelController showViewController:@"login"];
}
@end
