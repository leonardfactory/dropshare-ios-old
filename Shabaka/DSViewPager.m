//
//  DSViewPager.m
//  Shabaka
//
//  Created by Leonardo Ascione on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSViewPager.h"
#import "DSViewPageCell.h"

@interface DSViewPager ()
{
	int _loadedPages;
	int _page;
}

@property (strong, nonatomic) NSMutableArray *indexes;

@property (strong, nonatomic) NSMutableArray *visibleViewPages;
@property (strong, nonatomic) DSViewPageCell *reusableCell;

@end

@implementation DSViewPager

@synthesize indexes = _indexes;

@synthesize visibleViewPages = _visibleViewPages;
@synthesize reusableCell = _reusableCell;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	NSLog(@"Initializing with coder");
    if ((self = [super initWithCoder:aDecoder]))
	{
		[self setBounces:YES];
		[self setPagingEnabled:YES];
		[self setShowsHorizontalScrollIndicator:NO];
		
		[self setDelegate:self];
		
		_loadedPages = 0;
		_indexes = [[NSMutableArray alloc] init];
		_visibleViewPages = [[NSMutableArray alloc] initWithCapacity:3];
	}
	return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
}

- (void) setDataSourceAndStart:(id<DSViewPagerDataSource>) dataSource
{
	[self setDataSource:dataSource];
	[self loadViews];
}

- (void) loadViews
{
	/*
	 NSLog(@"Frame: %@", NSStringFromCGRect(self.frame));
	 [self setContentSize:CGSizeMake(DS_VIEW_PAGER_PAGE_WIDTH * 4, DS_VIEW_PAGER_PAGE_HEIGHT)];
	 
	 UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(DS_VIEW_PAGER_PAGE_WIDTH * 0, 0, DS_VIEW_PAGER_PAGE_WIDTH, DS_VIEW_PAGER_PAGE_HEIGHT)];
	 whiteView.backgroundColor = [UIColor blackColor];
	 
	 UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(DS_VIEW_PAGER_PAGE_WIDTH * 1, 0, DS_VIEW_PAGER_PAGE_WIDTH, DS_VIEW_PAGER_PAGE_HEIGHT)];
	 blueView.backgroundColor = [UIColor blueColor];
	 
	 UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(DS_VIEW_PAGER_PAGE_WIDTH * 2, 0, DS_VIEW_PAGER_PAGE_WIDTH, DS_VIEW_PAGER_PAGE_HEIGHT)];
	 greenView.backgroundColor = [UIColor greenColor];
	 
	 UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(DS_VIEW_PAGER_PAGE_WIDTH * 3, 0, DS_VIEW_PAGER_PAGE_WIDTH, DS_VIEW_PAGER_PAGE_HEIGHT)];
	 redView.backgroundColor = [UIColor redColor];
	 
	 [self addSubview:whiteView];
	 [self addSubview:blueView];
	 [self addSubview:greenView];
	 [self addSubview:redView];
	 
	 NSLog(@"Number of subviews: %d", [self.subviews count]);
	 */
	
	assert(self.dataSource != nil);
	
	_page = [self.dataSource firstPageForViewPager:self];
	
	/*
	 Carico la view iniziale.
	 Inoltre carico la view a sinistra e a destra, se disponibili
	 */
	[_visibleViewPages insertObject:[[DSViewPageCell alloc] init] atIndex:DS_LEFTVIEW_KEY];
	[_visibleViewPages insertObject:[[DSViewPageCell alloc] init] atIndex:DS_CENTERVIEW_KEY];
	[_visibleViewPages insertObject:[[DSViewPageCell alloc] init] atIndex:DS_RIGHTVIEW_KEY];
	
	int widthMultiplier = (_page == 0 && [_indexes count] == 1) ? 1 : ((_page == 0 || _page == ([_indexes count] - 1)) ? 2 : 3);
	self.contentSize = CGSizeMake(DS_VIEW_PAGER_PAGE_WIDTH * widthMultiplier, DS_VIEW_PAGER_PAGE_HEIGHT);
	
	_reusableCell = [_visibleViewPages objectAtIndex:DS_LEFTVIEW_KEY];
	if(![self isFirstPage:_page])
	{
		[self pushViewPage:[self.dataSource viewPageCellForViewPager:self atIndex:_page-1] atIndex:DS_LEFTVIEW_KEY];
	}
	
	_reusableCell = [_visibleViewPages objectAtIndex:DS_CENTERVIEW_KEY];
	[self pushViewPage:[self.dataSource viewPageCellForViewPager:self atIndex:_page] atIndex:DS_CENTERVIEW_KEY];
	
	_reusableCell = [_visibleViewPages objectAtIndex:DS_RIGHTVIEW_KEY];
	if(![self isLastPage:_page])
	{
		[self pushViewPage:[self.dataSource viewPageCellForViewPager:self atIndex:_page+1] atIndex:DS_RIGHTVIEW_KEY];
	}
	
	/*
	 Loading index paths and first item in the array
	 */
	
}

/**
 * Metodi utili per calcolarsi prima e ultima pagina, nonché
 * per aggiungere le celle (solo view senza content) per mostrarle
 * e averle caricate in cache.
 */
- (BOOL) isFirstPage:(int) page
{
	return (page == 0);
}

- (BOOL) isLastPage:(int) page
{
	return (page == [_indexes count] - 1);
}

- (void) pushViewPage:(DSViewPageCell *) viewPageCell atIndex:(NSUInteger) index
{
	[_visibleViewPages setObject:viewPageCell atIndexedSubscript:index];
	
	viewPageCell.frame = CGRectMake(_loadedPages * DS_VIEW_PAGER_PAGE_WIDTH, 0.0, viewPageCell.frame.size.width, viewPageCell.frame.size.height);
	[self addSubview:viewPageCell];
	
	_loadedPages++;
}

#pragma mark - External methods to handle viewPages

- (void) insertViewPageAtIndex:(int) index
{
	[_indexes insertObject:[NSNumber numberWithInt:index] atIndex:index];
}

- (void) removeViewPageAtIndex:(int) index
{
	[_indexes removeObjectAtIndex:index];
}

- (void) moveViewPageFromIndex:(int) oldIndex toIndex:(int) indexPath
{
	[_indexes removeObjectAtIndex:oldIndex];
	[_indexes insertObject:[NSNumber numberWithInt:indexPath] atIndex:indexPath];
}

- (DSViewPageCell *) dequeReusableViewPageCell
{
	return _reusableCell;
}

#pragma mark - UIScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *) sender
{
	/*
	 CGFloat pageWidth = self.frame.size.width;
	 int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	 */
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *) sender
{
	/*
	 Se la pagina centrale è cambiata (spostamento / 50%), aggiorno _page
	 */
	CGFloat pageWidth = self.frame.size.width;
    int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	
	if(page != _page && [self isValidPage:page])
	{
		[self updatePageFrom:_page toPage:page];
	}
}

/**
 * Aggiorno il contenuto in modo tale di mostrare la pagina _page
 */
- (BOOL) isValidPage:(int) page
{
	return (page >= 0) && (page < [_indexes count] - 1);
}

- (void) updatePageFrom:(int) oldPage toPage:(int) newPage
{
	assert(oldPage != newPage);
	
	_page = oldPage;
	BOOL leftSwipe = oldPage-newPage > 0;
	
	/*
	 Setto la cella che potrà essere riutilizzata perché non visibile.
	 Inoltre sposto le altre view
	 */
	NSLog(@"LeftSwipe: %d", leftSwipe);
	if(leftSwipe)
	{
		if(![self isFirstPage:_page])
		{
			[[_visibleViewPages objectAtIndex:DS_RIGHTVIEW_KEY] removeFromSuperview];
			_reusableCell = [_visibleViewPages objectAtIndex:DS_RIGHTVIEW_KEY];
			
			for(UIView* subview in self.subviews)
			{
				NSLog(@"subview: %@", subview);
				if([subview isKindOfClass:[DSViewPageCell class]])
				{
					subview.frame = CGRectOffset(subview.frame, DS_VIEW_PAGER_PAGE_WIDTH, 0.0f);
				}
			}
			
			DSViewPageCell *lvpc = [_visibleViewPages objectAtIndex:DS_LEFTVIEW_KEY];
			DSViewPageCell *cvpc = [_visibleViewPages objectAtIndex:DS_CENTERVIEW_KEY];
			
			[_visibleViewPages setObject:lvpc atIndexedSubscript:DS_CENTERVIEW_KEY];
			[_visibleViewPages setObject:cvpc atIndexedSubscript:DS_RIGHTVIEW_KEY];
			
			DSViewPageCell *addedCell = [self.dataSource viewPageCellForViewPager:self atIndex:_page-1];
			[_visibleViewPages setObject:addedCell atIndexedSubscript:DS_LEFTVIEW_KEY];
			
			addedCell.frame = CGRectMake(0.0f, 0.0f, DS_VIEW_PAGER_PAGE_WIDTH, DS_VIEW_PAGER_PAGE_HEIGHT);
			[self addSubview:addedCell];
		}
		else
		{
			[[_visibleViewPages objectAtIndex:DS_RIGHTVIEW_KEY] removeFromSuperview];
			_reusableCell = [_visibleViewPages objectAtIndex:DS_RIGHTVIEW_KEY];
			
			// se ci sono meno di due elementi?
			self.contentSize = CGSizeMake(DS_VIEW_PAGER_PAGE_WIDTH * 2, DS_VIEW_PAGER_PAGE_HEIGHT);
			self.contentOffset = CGPointMake(0.0f, 0.0f);
			
			DSViewPageCell *lvpc = [_visibleViewPages objectAtIndex:DS_LEFTVIEW_KEY];
			DSViewPageCell *cvpc = [_visibleViewPages objectAtIndex:DS_CENTERVIEW_KEY];
			
			[_visibleViewPages setObject:lvpc atIndexedSubscript:DS_CENTERVIEW_KEY];
			[_visibleViewPages setObject:cvpc atIndexedSubscript:DS_RIGHTVIEW_KEY];
		}
	}
	else
	{
		_reusableCell = [_visibleViewPages objectAtIndex:DS_LEFTVIEW_KEY];
	}
	
	
}

@end
