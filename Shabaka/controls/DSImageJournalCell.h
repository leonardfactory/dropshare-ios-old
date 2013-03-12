//
//  DSImageJournalCell.h
//  Shabaka
//
//  Created by Leonardo Ascione on 11/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSJournalCell.h"

@interface DSImageJournalCell : DSJournalCell

@property (strong, nonatomic) UIImageView *pictureImageView;
@property (strong, nonatomic) UIImageView *shadowPictureImageView;

+ (CGFloat) heightForCellWithText:(NSString *)text;

- (void) setPictureImage:(UIImage *)image;

@end
