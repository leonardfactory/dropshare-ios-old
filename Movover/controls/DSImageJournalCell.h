//
//  DSImageJournalCell.h
//  Movover
//
//  Created by Leonardo Ascione on 11/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSJournalCell.h"

@interface DSImageJournalCell : DSJournalCell

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UIImageView *shadowPictureImageView;

+ (CGFloat) heightForCellWithText:(NSString *)text;

- (void) setPictureWithURL:(NSURL *)imageURL;

@end
