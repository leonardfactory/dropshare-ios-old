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

@interface DSJournalTableViewController ()
{
	NSArray *randomNames;
	NSArray *randomTexts;
}

@end

@implementation DSJournalTableViewController

@synthesize cellData	= _cellData;
@synthesize imageData	= _imageData;
@synthesize textData	= _textData;

static NSString *JournalCellIdentifier		= @"JournalCell";
static NSString *ImageJournalCellIdentifier = @"ImageJournalCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
	
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
		 [that updateJournal];
	 }];
	[self.tableView addInfiniteScrollingWithActionHandler:^
	 {
		 [that loadMoreToJournal];
	 }];
	
    self.clearsSelectionOnViewWillAppear = YES;
}

/**
 * Aggiorno il journal con i drop più nuovi dal server.
 * @todo dispatch async del task di aggiornamento con un dispatch async finale sulla
 *		 main queue per lo stopAnimating;
 */
- (void) updateJournal
{
	NSLog(@"Inserting on TOP");
	
	// @todo Model
	int64_t delayInSeconds = 2.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		
		//[self.tableView beginUpdates];
		int randomNameId = arc4random() % [randomNames count];
		int randomTextId = arc4random() % [randomTexts count];
		
		[self.cellData insertObject:[randomNames objectAtIndex:randomNameId] atIndex:0];
		[self.textData insertObject:[randomTexts objectAtIndex:randomTextId] atIndex:0];
		[self.imageData insertObject:[NSNull null] atIndex:0];
		//[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]
		//					  withRowAnimation:UITableViewRowAnimationAutomatic];
		//[self.tableView endUpdates];
		
		[self.tableView reloadData];
		
		[self.tableView.pullToRefreshView stopAnimating];
	});
}

/**
 * Carico i drop più vecchi a partire dall'ultimo
 */
- (void) loadMoreToJournal
{
	NSLog(@"Insert on bottom");
	// @todo Model
	[self.tableView beginUpdates];
	[self.cellData addObject:@"Ginoska"];
	[self.textData addObject:@"Vivamus auctor leo vel dui. Aliquam erat volutpat. Phasellus nibh. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras tempor. Morbi egestas, urna non consequat tempus, nunc arcu mollis enim, eu aliquam erat nulla non nibh. Duis consectetuer malesuada velit. Nam ante nulla, interdum vel, tristique ac, condimentum non, tellus. Proin ornare feugiat nisl. Suspendisse dolor nisl, ultrices at, eleifend vel, consequat at, dolor."];
	[self.imageData addObject:@"mountain.jpg"];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.cellData.count-1 inSection:0]]
						  withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView endUpdates];
	
	[self.tableView.infiniteScrollingView stopAnimating];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	//	@todo Model
	//	[self.tableView triggerPullToRefresh];
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
	// @todo Model
    return [_cellData count];
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int index = [indexPath row];
	if([_imageData objectAtIndex:index] != [NSNull null])
	{
		return [DSImageJournalCell heightForCellWithText:[_textData objectAtIndex:index]];
	}
	else
	{
		return [DSJournalCell heightForCellWithText:[_textData objectAtIndex:index]];
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
	
	// Scegliamo l'identifier in base al tipo di dati da mostrare
	NSString *CellIdentifier = ([_imageData objectAtIndex:[indexPath row]] != [NSNull null]) ? ImageJournalCellIdentifier : JournalCellIdentifier;
	
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
	{
		cell = [self tableViewCellWithIdentifier:CellIdentifier];
	}
    
	// Cast forzato
	DSJournalCell *journalCell = (DSJournalCell *) cell;
	
	// Configurazione della cell
	// @todo Model
	journalCell.usernameLabel.text = [_cellData objectAtIndex:[indexPath row]];
	journalCell.descriptionLabel.text = [_textData objectAtIndex:[indexPath row]];
	[journalCell setGeoLocation:[NSString stringWithFormat:@"Via delle Rose n.%d", (int)floorf(powf(([indexPath row]+1)*2, 2.0))] andTime:@"11 Apr 2012"];
	
	[journalCell setAvatarWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lorempixel.com/96/96/people?v=%@", journalCell.usernameLabel.text]]];
	/*[journalCell setAvatarImage:[[UIImage imageNamed:@"avatar.png"] thumbnailImage:48
																 transparentBorder:0
																	  cornerRadius:0
															  interpolationQuality:kCGInterpolationHigh]];*/
	
	// Se è una image cell, aggiungo anche l'immagine
	if([cell isKindOfClass:[DSImageJournalCell class]])
	{
		DSImageJournalCell *imageJournalCell = (DSImageJournalCell *) cell;
		// @todo Model
		//UIImage *pictureImage	= [[UIImage imageNamed:[_imageData objectAtIndex:[indexPath row]]] thumbnailImage:292.0 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
		//[imageJournalCell setPictureImage:pictureImage];
		[imageJournalCell setPictureWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lorempixel.com/584/584?v=%@", journalCell.usernameLabel.text]]];
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
@end
