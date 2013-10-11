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

+ (instancetype) sharedManager;

- (void) captureWithImage:(UIImage *)image
                  andText:(NSString *) text;

- (DSAction *) actionWithId:(NSString *) identifier;
- (DSAction *) updateAndRetrieveActionWithId:(NSString *)identifier;

- (void) updateActionStatsWithId:(NSString *) identifier;

- (void) likeActionWithId:(NSString *) identifier;
- (void) likeAction:(DSAction *) action;
- (void) unlikeActionWithId:(NSString *) identifier;
- (void) unlikeAction:(DSAction *) action;

@end
