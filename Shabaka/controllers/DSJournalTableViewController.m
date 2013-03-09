//
//  DSJournalTableViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 09/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSJournalTableViewController.h"

@interface DSJournalTableViewController ()
{
	NSArray *cellData;
}

@end

@implementation DSJournalTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	cellData = [NSArray arrayWithObjects:@"Angelo", @"Beppe", @"Carlo", nil];
	
	UINib* reusableJournalCellNib = [UINib nibWithNibName:@"DSJournalCell" bundle:nil];
	[self.tableView registerNib:reusableJournalCellNib forCellReuseIdentifier:@"JournalCell"];

    self.clearsSelectionOnViewWillAppear = YES;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JournalCell";
	UITableViewCell *cell;
	
	if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)])
	{
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	}
	
	if(cell == nil)
	{
		cell = [[DSJournalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
	DSJournalCell *journalCell = (DSJournalCell *) cell;
    
	journalCell.usernameLabel.text = [cellData objectAtIndex:[indexPath row]];
	
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
