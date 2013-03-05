//
//  DSDiscoverViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 24/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSDiscoverViewController.h"

@interface DSDiscoverViewController ()
{
	ViewState _journalViewState;
	ViewState _mapViewState;
	
	NSMutableArray *cellData;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *journalView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet DSViewPager *viewPager;

@end

@implementation DSDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.tableView setSeparatorColor:[UIColor clearColor]];
	self.tableView.rowHeight = 80;
	
	_journalViewState.animation = DSViewAnimationStateNone;
	_mapViewState.animation		= DSViewAnimationStateNone;
	
	[self loadTestData];
	[self loadViewPager];
}

- (void) loadTestData
{
	/*[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:1]] withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:2]] withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:3]] withRowAnimation:UITableViewRowAnimationNone];*/
}

#pragma mark - ViewPager for drops
- (void) loadViewPager
{	
	[self.viewPager setDataSourceAndStart:self];
	cellData = [NSArray arrayWithObjects:@"Alfano",@"Bersani",@"Capezzone", nil];
	[self.viewPager insertViewPageAtIndex:0];
	[self.viewPager insertViewPageAtIndex:1];
	[self.viewPager insertViewPageAtIndex:2];
}

- (int) firstPageForViewPager:(DSViewPager *)viewPager
{
	return 1;
}

- (int) pageCountForViewPager:(DSViewPager *)viewPager
{
	return [cellData count];
}

- (DSViewPageCell *) viewPageCellForViewPager:(DSViewPager *)viewPager atIndex:(int)index
{
	DSViewPageCell *cell = [viewPager dequeReusableViewPageCell];
	
	cell.usernameLabel.text = (NSString *)[cellData objectAtIndex:index];
	cell.descriptionTextView.text = [NSString stringWithFormat:@"Sample descript #%d", index];
	
	return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
	[self setTableView:nil];
	[self setJournalView:nil];
	[self setMapView:nil];
	[self setViewPager:nil];
	[super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8; // @todo
}

- (void)configureCell:(DSJournalSimpleDropCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	int indexPathInt = indexPath.row;
	
	NSLog(@"Configuring cell %d", indexPathInt);
	
	cell.usernameLabel.text = [NSString stringWithFormat:@"Username #%d", indexPathInt];
	cell.descriptionLabel.text = [NSString stringWithFormat:@"This is just a description text that must be replaced."];
	/*
	 Qui ci va qualcosa tipo:
	 
	 Drop *drop = [Drop getDropByIndexPath:indexPath];
	 
	 cell.usernameLabel = drop.username;
	 cell.descriptionLabel = drop.description;
	 
	 // gestire il caricamento dell'avatar con AFImageRequest
	 
	 if(drop.imagePath)
	 {
		// caricamento dell'immagine con AFImageRequest
	 }
	 
	 cell.buttons
	 */
	
    //Exam* exam = [_fetchedResultsController objectAtIndexPath:indexPath];
    
    //cell.textLabel.text = exam.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@", exam.professor, exam.vote, [dateFormatter stringFromDate:exam.date]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// @todo custom cell for each drop type
    static NSString *CellIdentifier = @"singleJournalDrop";
    DSJournalSimpleDropCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    /*if(cell == nil)
    {
        cell = [[DSJournalSimpleDropCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:<#(NSString *)#> reuseIdentifier:CellIdentifier];
    }*/
	assert(cell != nil);
	NSLog(@"Loading indexPath: %@", indexPath);
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Trying to push view by indexPath: %@", indexPath);
}

#pragma mark - Show journal

- (IBAction)showJournalAction:(id)sender
{
	NSLog(@"Trying to show journal");
	
	/*
	 Permette di eseguire una sola animazione alla volta. Se sta mostrando, non è possibile ripremere
	 il pulsante.
	 */
	if((_journalViewState.animation != DSViewAnimationStateNone) || (_mapViewState.animation != DSViewAnimationStateNone))
	{
		return;
	}
	
	bool hidden = [self.journalView isHidden];
	_journalViewState.animation = hidden ? DSViewAnimationStateShow : DSViewAnimationStateHide;
	_mapViewState.animation = hidden ? DSViewAnimationStateResizeSmall : DSViewAnimationStateResizeFull;
	
	NSLog(@"Able to animate (Old: NONE) (New: %@) state: %d", hidden?@"Show":@"Hide", hidden);
	
	/*
	 Se non è mai stato caricato _journalViewState.visibleFrame, lo salvo perché vuol dire che
	 a) è quello originale non avendo mai mosso la tableView b) è la prima volta che
	 chiamo questo metodo. 
	 Idem per _mapViewState.visibleFrame
	 */
	if(CGRectIsEmpty(_journalViewState.visibleFrame))
	{
		_journalViewState.visibleFrame = self.journalView.frame;
	}
	
	if(CGRectIsEmpty(_mapViewState.visibleFrame))
	{
		_mapViewState.visibleFrame = self.mapView.frame;
	}
	
	/*
	 Calcolo il punto finale (y) in cui posizionare la tableView. Se è nascosta devo mostrarla
	 e viceversa. Inoltre, se è nascosta (per eliminarla dal rendering loop), la reinserisco 
	 per mostrare l'animazione.
	 Per quanto riguarda la mappa, calcolo se mostrarla full screen oppure resized
	 */
	float finalJournalViewY = (_journalViewState.animation == DSViewAnimationStateShow) ? _journalViewState.visibleFrame.origin.y : _journalViewState.visibleFrame.origin.y + _journalViewState.visibleFrame.size.height;
	float finalMapViewHeight = (_mapViewState.animation == DSViewAnimationStateResizeSmall) ? _mapViewState.visibleFrame.size.height : _mapViewState.visibleFrame.size.height + _journalViewState.visibleFrame.size.height;
	
	if(hidden)
	{
		self.journalView.hidden = false;
	}
	NSLog(@"FinalY: %f, because animation check result is: %d", finalJournalViewY, (_journalViewState.animation == DSViewAnimationStateShow));
	
	/*
	 Animazione della JournalView e della mappa
	 Eseguo l'animazione e al completamento setto `hidden` in base allo stato e resetto quest'ultimo
	 */
	[UIView animateWithDuration:0.25
					 animations:^{
						 self.journalView.frame = CGRectMake(self.journalView.frame.origin.x, finalJournalViewY, self.journalView.frame.size.width, self.journalView.frame.size.height);
						 self.mapView.frame = CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y, self.mapView.frame.size.width, finalMapViewHeight);
					 }
					 completion:^(BOOL finished){
						 self.journalView.hidden = (_journalViewState.animation == DSViewAnimationStateShow) ? false : true;
						 _journalViewState.animation	= DSViewAnimationStateNone;
						 _mapViewState.animation		= DSViewAnimationStateNone;
					 }];
}

@end
