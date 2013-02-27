//
//  DSViewPager.h
//  Shabaka
//
//  Created by Leonardo Ascione on 25/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSViewPageCell.h"

#define DS_VIEW_PAGER_PAGE_WIDTH 290.0f
#define DS_VIEW_PAGER_PAGE_HEIGHT 54.0f

const int DS_LEFTVIEW_KEY = 0;
const int DS_CENTERVIEW_KEY = 1;
const int DS_RIGHTVIEW_KEY = 2;

@class DSViewPager;

/**
 * Protocollo per fornire i contenuti al view pager
 */
@protocol DSViewPagerDataSource <NSObject>

- (int) firstPageForViewPager:(DSViewPager *)viewPager;
- (int) pageCountForViewPager:(DSViewPager *)viewPager;
- (DSViewPageCell *) viewPageCellForViewPager:(DSViewPager *)viewPager atIndex:(int) index;

@end

@interface DSViewPager : UIScrollView <UIScrollViewDelegate, NSCoding>

@property (weak, nonatomic) id<DSViewPagerDataSource> dataSource;

- (void) setDataSourceAndStart:(id<DSViewPagerDataSource>) dataSource;

- (void) insertViewPageAtIndex:(int) index;
- (void) removeViewPageAtIndex:(int) index;
- (void) moveViewPageFromIndex:(int) oldIndex toIndex:(int) indexPath;
- (DSViewPageCell *) dequeReusableViewPageCell;

@end
