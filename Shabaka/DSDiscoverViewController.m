//
//  DSDiscoverViewController.m
//  Shabaka
//
//  Created by Leonardo Ascione on 24/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSDiscoverViewController.h"

@interface DSDiscoverViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DSDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setTableView:nil];
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
    return 1; // @todo
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


@end
