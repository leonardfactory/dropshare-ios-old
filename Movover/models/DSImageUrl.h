//
//  DSImageUrl.h
//  Movover
//
//  Created by @leonardfactory on 14/03/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSImageUrl : NSObject

+ (NSString *) getAvatarUrlFromUserId:(NSString *) identifier;

+ (NSString *) getImageUrlFromDropId: (NSString *) identifier;

@end
