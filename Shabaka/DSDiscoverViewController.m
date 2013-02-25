//
//  DSDiscoverViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 24/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSDiscoverViewController.h"
#import "DSJournalSimpleDropCell.h"

@interface DSDiscoverViewController ()
{
	bool _willTableViewHide;
	CGRect _tableViewVisibleFrame;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DSDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.tableView setSeparatorColor:[UIColor clearColor]];
	self.tableView.rowHeight = 80;
	
	_willTableViewHide = false;
	_tableViewVisibleFrame = self.tableView.frame;
	NSLog(@"Height: %f, OriginY: %f", _tableViewVisibleFrame.size.width, _tableViewVisibleFrame.origin.y);
	
	[self loadTestData];
}

- (void) loadTestData
{
	/*[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:1]] withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:2]] withRowAnimation:UITableViewRowAnimationNone];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathWithIndex:3]] withRowAnimation:UITableViewRowAnimationNone];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
	[self setTableView:nil];
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
    DSJournalSimpleDropCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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
	float finalY = _willTableViewHide ? _tableViewVisibleFrame.origin.y : _tableViewVisibleFrame.origin.y + _tableViewVisibleFrame.size.height;
	_willTableViewHide = !_willTableViewHide;
	
	[UIView animateWithDuration:0.25
						  delay:0.0
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, finalY, self.tableView.frame.size.width, self.tableView.frame.size.height);
					 }
					 completion:^(BOOL finished){
						 if(_willTableViewHide) self.tableView.hidden = true;
					 }];
}

@end
