//
//  DSJournalTableViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSJournalTableViewController.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"

#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

#import "DSAddButton.h"
#import "DSAddViewController.h"

#import "DSImageUrl.h"

@interface DSJournalTableViewController ()
{
	NSArray *randomNames;
	NSArray *randomTexts;
}

@property (strong, nonatomic) DSJournalManager *journalManager;
@property (strong, nonatomic) DSAddButton *addButton;
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
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Configuring view
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.backgroundColor = [UIColor colorWithRed:238./255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
	
	float addButtonHeight = self.view.frame.size.height - kDSAddButtonSize - kDSAddButtonSize;
	//NSLog(@"Height: %f", addButtonHeight);
	//NSLog(@"View bounds: %@", NSStringFromCGRect(self.view.bounds));
	self.addButton = [[DSAddButton alloc] initWithFrame:CGRectMake(10.0, addButtonHeight, kDSAddButtonSize, kDSAddButtonSize)
											 andActions:[NSArray arrayWithObjects:@"actionMemo", @"actionCapture", nil]];
	[self.view addSubview:self.addButton];
	
	[self.addButton addObserver:self forKeyPath:@"actionCalled" options:NSKeyValueObservingOptionNew context:nil];
	
	//NSLog(@"Add button frame: %@", NSStringFromCGRect(self.addButton.frame));
	

	
	//<frank>
	_journalManager = [[DSJournalManager alloc] init];
	[_journalManager addObserver:self forKeyPath:@"isJournalUpdated" options:NSKeyValueObservingOptionNew context:nil];
	[_journalManager addObserver:self forKeyPath:@"isJournalScrolled" options:NSKeyValueObservingOptionNew context:nil];
	//</frank>
	
	// Just for testing
	_cellData = [NSMutableArray arrayWithObjects:	@"Angelo", @"Beppe", @"Carlo", @"Pino", nil];
	
	_textData = [NSMutableArray arrayWithObjects:	@"Il pezzo di pizza pazzo mangiava la pazza pezza del pozzo, col pizzo pazzo.",
				 @"Trentatre trentini entrarono a Trento tutti e trentatre trottellando",
				 @"Nel mezzo del cammin di nostra vita mi ritrovai per una selva oscura, si che la diritta via era smarrita.",
				 @"Ciao a tutti quanti, questo è il mio primo drop",
				 nil];
	
	_imageData = [NSMutableArray arrayWithObjects:	@"mountain.jpg",
				  [NSNull null],
				  @"frank.png",
				  [NSNull null],
				  nil];
	
	randomNames = [NSArray arrayWithObjects:@"Giovanni", @"Mario", @"Carletto", @"Giuseppe", @"Maria", @"Alda", @"Battista", nil];
	randomTexts = [NSArray arrayWithObjects:@"In massa massa, rhoncus non pharetra nec, vehicula eget nisi. Praesent pulvinar mi in purus laoreet commodo. Nulla tempor ligula.",
				   @"Morbi aliquam cursus nisi ac interdum. Pellentesque sit amet lacus lectus, id facilisis metus. Nam vel cursus mauris. Ut elit.",
				   @"Donec gravida molestie augue, sed sagittis risus pellentesque non. Etiam ultricies, velit quis suscipit convallis, est dolor vulputate velit, id.",
				   @"Praesent vehicula semper nibh, id aliquam magna consectetur ac. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus gravida porta tortor vel imperdiet.",
				   @"Maecenas vitae posuere eros. Duis mattis rhoncus lectus, at molestie odio convallis eu. Donec nec pharetra purus. Proin odio augue, aliquam ac tempus a, ornare eu urna.",
				   nil];
	
	
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
	
    //self.clearsSelectionOnViewWillAppear = YES;
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

/**
 * Gestisco la capture
 */
- (void) handleCapture
{
	DSAddViewController *addViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"addViewController"];
	addViewController.type = self.addButton.actionCalled;
	
	[self presentModalViewController:addViewController animated:YES];
}


/**
 * Aggiorno il journal con i drop più nuovi dal server.
 * @todo dispatch async del task di aggiornamento con un dispatch async finale sulla
 *		 main queue per lo stopAnimating;
 */
- (void) updateJournal
{
	//NSLog(@"Updating table with drops: %d", [_journalManager.drops count]);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_journalManager.drops count];
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int index = [indexPath row];
	Drop *drop = (Drop *)[_journalManager.drops objectAtIndex:index];
	
	if([[drop type] isEqualToString:@"capture"])
	{
		return [DSImageJournalCell heightForCellWithText:[drop text]];
	}
	else
	{
		return [DSJournalCell heightForCellWithText:[drop text]];
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
	Drop *drop = (Drop *)[_journalManager.drops objectAtIndex:index];
	
	// Scegliamo l'identifier in base al tipo di dati da mostrare
	NSString *CellIdentifier = ([drop.type isEqualToString:@"capture"]) ? ImageJournalCellIdentifier : JournalCellIdentifier;
	
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
	{
		cell = [self tableViewCellWithIdentifier:CellIdentifier];
	}
	
	cell.selectionStyle = UITableViewCellEditingStyleNone;
    
	// Cast forzato
	DSJournalCell *journalCell = (DSJournalCell *) cell;
	
	// Configurazione della cell
	journalCell.usernameLabel.text		= drop.user.username;
	journalCell.descriptionLabel.text	= drop.text;
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDoesRelativeDateFormatting:YES];
	[dateFormatter setLocale: [NSLocale autoupdatingCurrentLocale]];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	
	[journalCell setGeoLocation:[NSString stringWithFormat:@"Via delle Rose n.%d", (int)floorf(powf(([indexPath row]+1)*2, 2.0))] andTime:[dateFormatter stringFromDate:drop.createdOn]];
	
	[journalCell setAvatarWithURL:[NSURL URLWithString:[DSImageUrl getAvatarUrlFromUserId:drop.user.identifier]]];
	/*[journalCell setAvatarImage:[[UIImage imageNamed:@"avatar.png"] thumbnailImage:48
																 transparentBorder:0
																	  cornerRadius:0
															  interpolationQuality:kCGInterpolationHigh]];*/
	
	// Se è una image cell, aggiungo anche l'immagine
	if([cell isKindOfClass:[DSImageJournalCell class]])
	{
		DSImageJournalCell *imageJournalCell = (DSImageJournalCell *) cell;
		// @todo
		//NSLog(@"%@",[DSImageUrl getImageUrlFromDropId:drop.identifier]);
		[imageJournalCell setPictureWithURL:[NSURL URLWithString:[DSImageUrl getImageUrlFromDropId:drop.identifier]]];
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
