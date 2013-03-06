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
	ViewState _dropSwipeViewState;
	
	NSMutableArray *cellData;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *journalView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet UIView *swipeViewContainer;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapOnMapRecognizer;

@end

@implementation DSDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.tableView setSeparatorColor:[UIColor clearColor]];
	self.tableView.rowHeight = 80;
	
	_dropSwipeViewState.animation	= DSViewAnimationStateNone;
	_journalViewState.animation		= DSViewAnimationStateNone;
	_mapViewState.animation			= DSViewAnimationStateNone;
	
	/*
	 Recognize double tap on map to show/hide journal
	 */
	self.doubleTapOnMapRecognizer = [[UITapGestureRecognizer alloc]
								   initWithTarget:self action:@selector(handleDoubleTapOnMap:)];
	self.doubleTapOnMapRecognizer.numberOfTapsRequired = 2;
	self.doubleTapOnMapRecognizer.numberOfTouchesRequired = 1;
	self.doubleTapOnMapRecognizer.delegate = self;
	self.doubleTapOnMapRecognizer.enabled = false; // will be enabled on showJournal
	[self.mapView addGestureRecognizer:self.doubleTapOnMapRecognizer];
	
	[self loadTestData];
	[self loadSwipeView];
}

- (void) loadTestData
{
	/*[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:1]] withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:2]] withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:3]] withRowAnimation:UITableViewRowAnimationNone];*/
}

#pragma mark - ViewPager for drops
- (void) loadSwipeView
{	
	cellData = [NSArray arrayWithObjects:@"Alfano",@"Bersani",@"Capezzone", nil];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView;
{
	return [cellData count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
	DSViewPageCell *viewPageCell;
	
	viewPageCell = view == nil ? [[DSViewPageCell alloc] init] : (DSViewPageCell *) view;
	
	viewPageCell.usernameLabel.text = (NSString *)[cellData objectAtIndex:index];
	viewPageCell.descriptionTextView.text = [NSString stringWithFormat:@"Description #%d", index];
	
	return viewPageCell;
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

#pragma mark - Double tap recognizer on mapView
/**
 * Mostro il journal se faccio doppio click sulla mappa piccola
 */
- (void)handleDoubleTapOnMap:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
	
	if(![self.journalView isHidden])
	{
		
	}
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{	
	if(otherGestureRecognizer == self.doubleTapOnMapRecognizer)
	{
		return YES;
	}
	else
	{
		return NO;
	}
}

#pragma mark - Show journal

- (IBAction)showJournalAction:(id)sender
{
	
}

- (void) showJournal:(id) sender
{
	/*
	 Permette di eseguire una sola animazione alla volta. Se sta mostrando, non è possibile ripremere
	 il pulsante.
	 */
	if((_journalViewState.animation != DSViewAnimationStateNone) || (_mapViewState.animation != DSViewAnimationStateNone) || (_dropSwipeViewState.animation != DSViewAnimationStateNone))
	{
		return;
	}
	
	/*
	 hidden rappresenta il fatto che self.journalView sia nascosta, dunque ciò
	 è vero quando self.swipeViewContainer è mostrata.
	 */
	bool hidden = ![self.swipeViewContainer isHidden];
	_journalViewState.animation		= hidden ? DSViewAnimationStateShow			: DSViewAnimationStateHide;
	_mapViewState.animation			= hidden ? DSViewAnimationStateResizeSmall	: DSViewAnimationStateResizeFull;
	_dropSwipeViewState.animation	= hidden ? DSViewAnimationStateHide			: DSViewAnimationStateShow;
	
	/*
	 Se non è mai stato caricato _journalViewState.visibleFrame, lo salvo perché vuol dire che
	 a) è quello originale non avendo mai mosso la tableView b) è la prima volta che
	 chiamo questo metodo.
	 Idem per _mapViewState.visibleFrame
	 */
	if(CGRectIsEmpty(_journalViewState.visibleFrame))
	{
		_journalViewState.visibleFrame = CGRectOffset(self.journalView.frame, 0.0f, -self.journalView.frame.size.height);
	}
	
	if(CGRectIsEmpty(_mapViewState.visibleFrame))
	{
		_mapViewState.visibleFrame = self.mapView.frame;
	}
	
	if(CGRectIsEmpty(_dropSwipeViewState.visibleFrame))
	{
		_dropSwipeViewState.visibleFrame = self.swipeViewContainer.frame;
	}
	
	/*
	 Calcolo il punto finale (y) in cui posizionare la tableView. Se è nascosta devo mostrarla
	 e viceversa. Inoltre, se è nascosta (per eliminarla dal rendering loop), la reinserisco
	 per mostrare l'animazione.
	 Per quanto riguarda la mappa, calcolo se mostrarla full screen oppure resized
	 */
	float finalJournalViewY		= (_journalViewState.animation	 == DSViewAnimationStateShow)		? _journalViewState.visibleFrame.origin.y	: _journalViewState.visibleFrame.origin.y + _journalViewState.visibleFrame.size.height;
	float finalMapViewHeight	= (_mapViewState.animation		 == DSViewAnimationStateResizeFull) ? _mapViewState.visibleFrame.size.height	: _mapViewState.visibleFrame.size.height - _journalViewState.visibleFrame.size.height;
	float finalSwipeViewY		= (_dropSwipeViewState.animation == DSViewAnimationStateShow)		? _dropSwipeViewState.visibleFrame.origin.y : _dropSwipeViewState.visibleFrame.origin.y - _dropSwipeViewState.visibleFrame.size.height - 20.0;
	
	if(hidden)
	{
		self.journalView.hidden = false;
	}
	else
	{
		self.swipeViewContainer.hidden = false;
	}
	NSLog(@"FinalY: %f, because animation check result is: %d", finalJournalViewY, (_journalViewState.animation == DSViewAnimationStateShow));
	
	/*
	 Animazione della JournalView e della mappa
	 Eseguo l'animazione e al completamento setto `hidden` in base allo stato e resetto quest'ultimo
	 */
	[UIView animateWithDuration:0.25
					 animations:^{
						 self.swipeViewContainer.frame	= CGRectMake(self.swipeViewContainer.frame.origin.x, finalSwipeViewY, self.swipeViewContainer.frame.size.width, self.swipeViewContainer.frame.size.height);
						 self.journalView.frame			= CGRectMake(self.journalView.frame.origin.x, finalJournalViewY, self.journalView.frame.size.width, self.journalView.frame.size.height);
						 self.mapView.frame				= CGRectMake(self.mapView.frame.origin.x, self.mapView.frame.origin.y, self.mapView.frame.size.width, finalMapViewHeight);
					 }
					 completion:^(BOOL finished){
						 self.journalView.hidden		= (_journalViewState.animation == DSViewAnimationStateShow) ? false : true;
						 self.swipeViewContainer.hidden = (_dropSwipeViewState.animation == DSViewAnimationStateShow) ? false : true;
						 
						 self.doubleTapOnMapRecognizer.enabled = (_mapViewState.animation == DSViewAnimationStateResizeSmall) ? true : false;
						 
						 _journalViewState.animation	= DSViewAnimationStateNone;
						 _mapViewState.animation		= DSViewAnimationStateNone;
						 _dropSwipeViewState.animation	= DSViewAnimationStateNone;
					 }];
} 

#pragma mark - Final view methods

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
	[self setSwipeView:nil];
	[self setSwipeViewContainer:nil];
	[super viewDidUnload];
}

@end
