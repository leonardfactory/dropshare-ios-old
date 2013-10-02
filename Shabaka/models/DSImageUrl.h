//
//  DSImageUrl.h
//  Shabaka
//
//  Created by Francesco on 14/03/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSImageUrl : NSObject

+ (NSString *) getAvatarUrlFromUserId:(NSString *) identifier;

+ (NSString *) getImageUrlFromDropId: (NSString *) identifier;

@end
