//
//  DSAppDelegate.h
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSManagedObjectContext+blocks.h"

@interface DSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
