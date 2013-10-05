//
//  DSNewDropManager.h
//  Movover
//
//  Created by @leonardfactory on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSEntityManager.h"

@interface DSNewDropManager : DSEntityManager

@property (readonly, strong, nonatomic) DSAction *action;

- (void) captureWithImage:(UIImage *)image WithText:(NSString *) text;

- (void) memoWithText:(NSString *) text;

@end
