//
//  DSActionManager.h
//  Movover
//
//  Created by Leonardo on 06/10/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSEntityManager.h"
#import "DSAction.h"

#import <Cloudinary/Cloudinary.h>

@interface DSActionManager : DSEntityManager <CLUploaderDelegate>

@property (strong, nonatomic) DSAction *action;

- (void) captureWithImage:(UIImage *)image andText:(NSString *) text;

@end
