//
//  DSJournalTableViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSJournalTableViewController.h"
#import "UIImage+Resize.h"

@interface DSJournalTableViewController ()
{
	NSArray *cellData;
	NSArray *textData;
	NSArray *imageData;
}

@end

@implementation DSJournalTableViewController

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
	
	UINib* reusableJournalCellNib = [UINib nibWithNibName:@"DSJournalCell" bundle:nil];
	[self.tableView registerNib:reusableJournalCellNib forCellReuseIdentifier:@"JournalCell"];

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
	float descriptionLabelHeight = [[textData objectAtIndex:[indexPath row]] sizeWithFont:[UIFont systemFontOfSize:16.0f]
																		constrainedToSize:CGSizeMake(236.0, FLT_MAX)
																			lineBreakMode:UILineBreakModeWordWrap].height;
	
//	NSLog(@"Calculated height: %f, Added: %f", descriptionLabelHeight, descriptionLabelHeight + 40.0);
	return descriptionLabelHeight + 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JournalCell";
	UITableViewCell *cell;
	
	if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
	{
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
	else
	{// iOS 5 fix
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	}
	
	if(cell == nil)
	{// Alloc della cell dal UINib registrato nell'init
		cell = [[DSJournalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
															  interpolationQuality:kCGInterpolationDefault]];
	
	// Test immagine del drop
	if([imageData objectAtIndex:[indexPath row]] != [NSNull null])
	{
		UIImage *pictureImage = [UIImage imageNamed:[imageData objectAtIndex:[indexPath row]]];
		UIImageView *pictureImageView = [[UIImageView alloc] initWithImage:pictureImage];
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
