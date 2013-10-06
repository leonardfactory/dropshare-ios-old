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

#import "DSImageUrl.h"

#import "DSUserManager.h"

@interface DSJournalTableViewController ()
{
	NSArray *randomNames;
	NSArray *randomTexts;
}

@property (strong, nonatomic) DSJournalManager *journalManager;
@property (strong, nonatomic) DSAddButton *addButton;
@property (strong, nonatomic) DSCapturePicker *capturePicker;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DSJournalTableViewController

@synthesize journalManager = _journalManager;
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
    
    NSLog(@"View loaded");
	
	_journalManager = [[DSJournalManager alloc] init];
	[_journalManager addObserver:self forKeyPath:@"isJournalUpdated" options:NSKeyValueObservingOptionNew context:nil];
	[_journalManager addObserver:self forKeyPath:@"isJournalScrolled" options:NSKeyValueObservingOptionNew context:nil];
	
	
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
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.backgroundColor = [UIColor colorWithRed:238./255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
	
	float addButtonHeight = self.view.frame.size.height - kDSAddButtonSize - kDSAddButtonSize;
	self.addButton = [[DSAddButton alloc] initWithFrame:CGRectMake(10.0,
																   addButtonHeight,
																   kDSAddButtonSize,
																   kDSAddButtonSize)
											 andActions:[NSArray arrayWithObjects:@"actionMemo", @"actionCapture", nil]];
	[self.view addSubview:self.addButton];
	
	[self.addButton addObserver:self forKeyPath:@"actionCalled" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	//<frank>
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
	//</frank>
	
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
	
    // User (faked per ora, non è detto che lo sia)
    DSUser *user = [[DSUserManager sharedManager] userWithId:activity.subjectId];
    
	// Configurazione della cell
	journalCell.usernameLabel.text		= user.username;
	journalCell.descriptionLabel.text	= activity.data[@"text"];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDoesRelativeDateFormatting:YES];
	[dateFormatter setLocale: [NSLocale autoupdatingCurrentLocale]];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	
	[journalCell setGeoLocation:[NSString stringWithFormat:@"Via delle Rose n.%d", (int)floorf(powf(([indexPath row]+1)*2, 2.0))] andTime:[dateFormatter stringFromDate:activity.createdOn]];
	
	//[journalCell setAvatarWithURL:[NSURL URLWithString:[DSImageUrl getAvatarUrlFromUserId:drop.user.identifier]]];
	[journalCell setAvatarImage:[[UIImage imageNamed:@"avatar.png"] thumbnailImage:48
																 transparentBorder:0
																	  cornerRadius:0
															  interpolationQuality:kCGInterpolationHigh]];
	
	// Se è una image cell, aggiungo anche l'immagine
	if([cell isKindOfClass:[DSImageJournalCell class]])
	{
		DSImageJournalCell *imageJournalCell = (DSImageJournalCell *) cell;
		// @todo
		//NSLog(@"%@",[DSImageUrl getImageUrlFromDropId:drop.identifier]);
		//[imageJournalCell setPictureWithURL:[NSURL URLWithString:[DSImageUrl getImageUrlFromDropId:drop.identifier]]];
	}
	
	// Ridispone gli elementi della cell in base ai parametri passati
	[journalCell recalculateSizes];
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
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
