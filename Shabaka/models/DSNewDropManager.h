//
//  DSNewDropManager.h
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import "DSEntityManager.h"

@interface DSNewDropManager : DSEntityManager

@property (readonly, strong, nonatomic) Drop *drop;

- (void) captureWithImage:(UIImage *)image WithText:(NSString *) text;

- (void) memoWithText:(NSString *) text;

@end
