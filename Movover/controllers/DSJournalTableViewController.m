//
//  DSJournalTableViewController.m
//  Movover
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSJournalTableViewController.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"

#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

#import "DSAddButton.h"
#import "DSCapturePicker.h"

#import "DSCloudinary.h"

#import "DSUserManager.h"
#import "DSActionManager.h"

#import <NSDate+TimeAgo.h>

@interface DSJournalTableViewController ()
{
	NSArray *randomNames;
	NSArray *randomTexts;
}

@property (strong, nonatomic) DSJournalManager *journalManager;
@property (strong, nonatomic) DSActionManager *actionManager;
@property (strong, nonatomic) DSAddButton *addButton;
@property (strong, nonatomic) DSCapturePicker *capturePicker;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DSJournalTableViewController

@synthesize journalManager = _journalManager;
@synthesize actionManager = _actionManager;
@synthesize cellData	= _cellData;
@synthesize imageData	= _imageData;
@synthesize textData	= _textData;

static NSString *JournalCellIdentifier		= @"JournalCell";
static NSString *ImageJournalCellIdentifier = @"ImageJournalCell";

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self)
	{
		self.capturePicker = [[DSCapturePicker alloc] initWithController:self];
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self buildView];
	
	_journalManager = [[DSJournalManager alloc] init];
	[_journalManager addObserver:self forKeyPath:@"isJournalUpdated" options:NSKeyValueObservingOptionNew context:nil];
	[_journalManager addObserver:self forKeyPath:@"isJournalScrolled" options:NSKeyValueObservingOptionNew context:nil];
    
    _actionManager = [DSActionManager sharedManager];
	
	
	__weak DSJournalTableViewController *that = self;
	
	// Setto gli handler per il pull to refresh e l'infinite scrolling
	[self.tableView addPullToRefreshWithActionHandler:^
	 {
		 [that.journalManager pullToRefresh];
	 }];
	[self.tableView addInfiniteScrollingWithActionHandler:^
	 {
         [that.journalManager scrollDown];
	 }];
}

#pragma mark - UIView modifications
- (void) buildView
{
    // Style navigationBar with logo
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    self.navigationItem.titleView = imageView;
    
    // Remove translucent
    [self.navigationController.navigationBar setTranslucent:NO];
    
    // Style tableView
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:234.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.tableView.contentInset = UIEdgeInsetsMake(kDSCellPictureTopGap, 0, 0, 0);
    
    // Add button
	float addButtonHeight = self.view.frame.size.height - kDSAddButtonSize - kDSAddButtonPadding - 44 - 20; // Removing also NavBar + StatusBar height
	self.addButton = [[DSAddButton alloc] initWithFrame:CGRectMake(kDSAddButtonPadding,
																   addButtonHeight,
																   kDSAddButtonSize,
																   kDSAddButtonSize)
											 andActions:[NSArray arrayWithObjects:@"actionMemo", @"actionCapture", nil]
                                          andSuperFrame:self.view.frame];
    
	[self.view addSubview:self.addButton];
	
	[self.addButton addObserver:self forKeyPath:@"actionCalled" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"isJournalUpdated"]
	   && [object isEqual:_journalManager]
	   && ((DSJournalManager *)object).isJournalUpdated)
	{
		[self updateJournal];
	}
	
	if([keyPath isEqualToString:@"isJournalScrolled"]
	   && [object isEqual:_journalManager]
	   && ((DSJournalManager *)object).isJournalScrolled)
	{
		[self scrollDownJournal];
	}
	
	if([keyPath isEqualToString:@"actionCalled"]
		&& [object isEqual:self.addButton])
	{
		if([self.addButton.actionCalled isEqualToString:@"actionCapture"])
		{
			[self handleCapture];
		}
	}
		
}

#pragma mark - Capture and Photo Handling
/**
 * Gestisco la capture
 */
- (void) handleCapture
{
	[self.capturePicker showCapture];
}

#pragma mark Journal updater
/**
 * Aggiorno il journal con i drop più nuovi dal server.
 * @todo dispatch async del task di aggiornamento con un dispatch async finale sulla
 *		 main queue per lo stopAnimating;
 */
- (void) updateJournal
{
	[self.tableView reloadData];
	
	[self.tableView.pullToRefreshView stopAnimating];
}

/**
 * Carico i drop più vecchi a partire dall'ultimo
 */
- (void) scrollDownJournal
{
	[self.tableView reloadData];
	
	[self.tableView.infiniteScrollingView stopAnimating];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self.tableView triggerPullToRefresh];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_journalManager.journal.activities count];
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int index = [indexPath row];
	DSActivity *activity = (DSActivity *)[_journalManager.journal.activities objectAtIndex:index];
    //NSDictionary *data = (NSDictionary *)[activity data];
    
	if([[activity.data valueForKey:@"type"] isEqualToString:@"capture"])
	{
		return [DSImageJournalCell heightForCellWithText:activity.data[@"text"]];
	}
	else
	{
		return [DSJournalCell heightForCellWithText:activity.data[@"text"]];
	}
}

/**
 * Crea una tableViewCell in base all'identifier passato
 */
- (UITableViewCell *)tableViewCellWithIdentifier:(NSString *)identifier
{
	if([identifier isEqualToString:JournalCellIdentifier])
	{
		return [[DSJournalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JournalCellIdentifier];
	}
	
	if([identifier isEqualToString:ImageJournalCellIdentifier])
	{
		return [[DSImageJournalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageJournalCellIdentifier];
	}
	
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	
	int index = [indexPath row];
	DSActivity *activity = (DSActivity *)[_journalManager.journal.activities objectAtIndex:index];
	
	// Scegliamo l'identifier in base al tipo di dati da mostrare
	NSString *CellIdentifier = ([activity.data[@"type"] isEqualToString:@"capture"]) ? ImageJournalCellIdentifier : JournalCellIdentifier;
	
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
	{
		cell = [self tableViewCellWithIdentifier:CellIdentifier];
	}
	
	cell.selectionStyle = UITableViewCellEditingStyleNone;
    
	// Cast forzato
	DSJournalCell *journalCell = (DSJournalCell *) cell;
    [journalCell setIdentifier:activity.identifier];
	
    // User
    DSUser *user = [[DSUserManager sharedManager] userWithId:activity.subjectId];
    
    // Action
    DSAction *action = [_actionManager actionWithId:activity.objectId];
    
    // Update action with new stats
    [[DSActionManager sharedManager] updateActionStatsWithId:activity.objectId];
    
	// Configurazione della cell con i dati dell'utente e dell'activity
    journalCell.nameLabel.text          = user.completeName;
	journalCell.usernameLabel.text		= [NSString stringWithFormat:@"@%@", user.username];
	journalCell.descriptionLabel.text	= activity.data[@"text"];
    
    // Area e createdOn
	[journalCell setGeoLocation:activity.area.name andTime:[activity.createdOn timeAgo]];
    
    // Social buttons
    [journalCell.socialButtonsBarView setLikes:action.statsLike andComments:action.statsComment andReactions:action.statsReaction];
    [journalCell.socialButtonsBarView.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Like personale
    [journalCell.socialButtonsBarView applyStyleForLike:[action.like boolValue]];
	
    // Avatar with url
    NSString *avatarImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"user_avatar_%@.jpg", user.identifier]];
    [journalCell setAvatarWithURL:[NSURL URLWithString:avatarImageURL]];
	
	// Se è una image cell, aggiungo anche l'immagine
	if([cell isKindOfClass:[DSImageJournalCell class]])
	{
		DSImageJournalCell *imageJournalCell = (DSImageJournalCell *) cell;
        // Activity image url
        NSString *actionImageURL = [[[DSCloudinary sharedInstance] cloudinary] url:[NSString stringWithFormat:@"action_%@.jpg", activity.objectId]];
        [imageJournalCell setPictureWithURL:[NSURL URLWithString:actionImageURL]];
	}
	
	// Ridispone gli elementi della cell in base ai parametri passati
	[journalCell recalculateSizes];
	
    return cell;
}

#pragma mark - Social buttons
- (void) likeButtonPressed:(id) sender
{
    // Get activity
    UIButton *likeButton = (UIButton *) sender;
    DSJournalCell *journalCell = (DSJournalCell *)[[likeButton.superview superview] superview]; // LikeButton -> SocialButtons -> DSJournalCell
    NSIndexPath* cellPath = [self.tableView indexPathForCell:journalCell];
    NSInteger index = [cellPath row];
    
    DSActivity *activity = (DSActivity *)[_journalManager.journal.activities objectAtIndex:index];
    DSAction *action = [_actionManager actionWithId:activity.objectId];
    
    if([journalCell canPerformLike])
    {
        if([action.like boolValue] == YES) {
            // unlike
            [_actionManager unlikeAction:action];
            [journalCell.socialButtonsBarView animateUnlike];
        }
        else {
            // like
            [_actionManager likeAction:action]; // @todo only actions?
            [journalCell.socialButtonsBarView animateLike];
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [indexPath row];
    DSActivity *activity = (DSActivity *)[_journalManager.journal.activities objectAtIndex:index];
    
    // Navigation logic may go here. Create and push another view controller.
    if([activity.verb isEqualToString:@"publish_action"])
    {
        DSActionViewController *actionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"actionViewController"];
        [actionViewController buildWithAction:[_actionManager updateAndRetrieveActionWithId:activity.objectId]];
        
        [self.navigationController pushViewController:actionViewController animated:YES];
    }
    else
    {
    }
    
    /*
     *detailViewController = [[ alloc] initWithNibName:@"   " bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/**
 * Se sto per mostrare l'ultimo elemento, carico i 20 successivi.
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	/* if([indexPath row] == [_cellData count] - 1)
	{
		[self.tableView triggerInfiniteScrolling];
	} */
}
- (void)viewDidUnload {
	[self setTableView:nil];
	[super viewDidUnload];
}
@end
