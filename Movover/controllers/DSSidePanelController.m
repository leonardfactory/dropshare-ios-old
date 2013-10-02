//
//  MainSidePanelController.m
//  Dropshare
//
//  Created by Leonardo Ascione on 04/02/13.
//  Copyright (c) 2013 Leonardo Ascione. All rights reserved.
//

#import "DSSidePanelController.h"

@interface DSSidePanelController ()

@end

@implementation DSSidePanelController

@synthesize selectedViewControllerName = _selectedViewControllerName;
@synthesize loadedViewControllers =	_loadedViewControllers;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
} */

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftSidePanelViewController"]];
    
	//[self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"journalViewController"]];
    //[self setRightPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"rightViewController"]];
}

#pragma mark - Container
- (void) setViewControllers:(NSDictionary *)objects whereSelectedIs:(NSString *) name
{
    NSLog(@"AddedViewControllers");
    _loadedViewControllers = [objects copy]; // @todo: side effect? corretto?
    
    [self setCenterPanel:[_loadedViewControllers objectForKey:name]];
}

- (void) showViewController:(NSString *)identifier
{
    if([_selectedViewControllerName isEqualToString:identifier])
    {
        [self showCenterPanel:YES];
    }
    else
    {
        [self setCenterPanel:[_loadedViewControllers objectForKey:identifier]];
        _selectedViewControllerName = identifier;
    }
}

- (UIViewController *) selectedViewController
{
    return [_loadedViewControllers objectForKey:_selectedViewControllerName];
}
@end
