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

@interface DSJournalTableViewController ()
{
	NSArray *cellData;
	NSArray *textData;
	NSArray *imageData;
}

@end

@implementation DSJournalTableViewController

static NSString *JournalCellIdentifier		= @"JournalCell";
static NSString *ImageJournalCellIdentifier = @"ImageJournalCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	cellData = [NSArray arrayWithObjects:@"Angelo", @"Beppe", @"Carlo", nil];
	
	textData = [NSArray arrayWithObjects:	@"Il pezzo di pizza pazzo mangiava la pazza pezza del pozzo, col pizzo pazzo.",
											@"Trentatre trentini entrarono a Trento tutti e trentatre trottellando",
											@"Nel mezzo del cammin di nostra vita mi ritrovai per una selva oscura, si che la diritta via era smarrita.",
											nil];
	
	imageData = [NSArray arrayWithObjects:	@"mountain.jpg",
											[NSNull null],
											@"frank.png",
											nil];
	
//	UINib* reusableJournalCellNib = [UINib nibWithNibName:@"DSJournalCell" bundle:nil];
//	[self.tableView registerNib:reusableJournalCellNib forCellReuseIdentifier:@"JournalCell"];

    self.clearsSelectionOnViewWillAppear = YES;
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellData count];
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int index = [indexPath row];
	if([imageData objectAtIndex:index] != [NSNull null])
	{
		return [DSImageJournalCell heightForCellWithText:[textData objectAtIndex:index]];
	}
	else
	{
		return [DSJournalCell heightForCellWithText:[textData objectAtIndex:index]];
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
	NSString *CellIdentifier = ([imageData objectAtIndex:[indexPath row]] != [NSNull null]) ? ImageJournalCellIdentifier : JournalCellIdentifier;

	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
	{
		cell = [self tableViewCellWithIdentifier:CellIdentifier];
	}
    
	// Cast forzato
	DSJournalCell *journalCell = (DSJournalCell *) cell;
	
	// Configurazione della cell
	journalCell.usernameLabel.text = [cellData objectAtIndex:[indexPath row]];
	journalCell.descriptionLabel.text = [textData objectAtIndex:[indexPath row]];
	
	// Test avatar image
	[journalCell setAvatarImage:[[UIImage imageNamed:@"avatar.png"] thumbnailImage:48
																 transparentBorder:0
																	  cornerRadius:3
															  interpolationQuality:kCGInterpolationHigh]];
	
	// Test immagine del drop
	if([cell isKindOfClass:[DSImageJournalCell class]])
	{
		DSImageJournalCell *imageJournalCell = (DSImageJournalCell *) cell;
		
		UIImage *pictureImage	= [[UIImage imageNamed:[imageData objectAtIndex:[indexPath row]]] resizedImageWithContentMode:UIViewContentModeScaleAspectFit
																													   bounds:CGSizeMake(292.0, 160.0)
																										 interpolationQuality:kCGInterpolationHigh];
		
		[imageJournalCell setPictureImage:pictureImage];
	}
	
	[journalCell recalculateSizes];
	
	NSLog(@"JournalCell #%d, Calculated label frame size: %f, Background size: %f", [indexPath row], journalCell.descriptionLabel.frame.size.height, journalCell.mainBackgroundImageView.frame.size.height);
	
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

@end
