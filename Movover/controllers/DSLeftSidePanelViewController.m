//
//  DSLeftSidePanelViewController.m
//  Movover
//
//  Created by Leonardo Ascione on 23/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSSidePanelController.h"
#import "UIViewController+SidePanel.h"

#import "DSLeftSidePanelViewController.h"

#import "UIImage+FromColor.h"

@interface DSLeftSidePanelViewController ()

@property (weak, nonatomic) IBOutlet UIButton *menuButtonDiscover;
@property (weak, nonatomic) IBOutlet UIButton *menuButtonJournal;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation DSLeftSidePanelViewController

// @todo: aggiungere initWithCoder

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Codice per personalizzare l'onclick background
	//UIImage *menuButtonBgPressedPattern = [[UIImage imageNamed:@"menuButtonBgPressed"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    UIColor *buttonBackgroundColor = [UIColor colorWithRed:228.0/255.0 green:234.0/255.0 blue:232.0/255.0 alpha:1.0];
    UIImage *menuButtonBackgroundPressedImage = [[UIImage imageWithColor:buttonBackgroundColor] resizableImageWithCapInsets:UIEdgeInsetsZero];
    
    [self.menuButtonDiscover setBackgroundImage:menuButtonBackgroundPressedImage forState:UIControlStateHighlighted];
	[self.menuButtonJournal  setBackgroundImage:menuButtonBackgroundPressedImage forState:UIControlStateHighlighted];

    [self.menuButtonDiscover setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.menuButtonJournal  setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    // Personalizzazione search bar
    UIColor *searchBarBackgroundColor = [UIColor colorWithRed:204./255. green:204./255. blue:204./255. alpha:1.0];
    [self.searchBar setBackgroundImage:[UIImage imageWithColor:searchBarBackgroundColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
	[self setMenuButtonDiscover:nil];
	[self setMenuButtonJournal:nil];
	[super viewDidUnload];
}

- (IBAction)menuButtonDiscoverTouched:(id)sender
{
	[self.sidePanelController showViewController:@"map"];
}

- (IBAction)journalButtonTouched:(id)sender
{
	[self.sidePanelController showViewController:@"journal"];
}
@end
