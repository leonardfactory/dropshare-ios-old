//
//  DSAppDelegate.h
//  Shabaka
//
//  Created by Francesco on 23/02/13.
//  Copyright (c) 2013 Dropshare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSManagedObjectContext+blocks.h"
#import "DSLoginViewController.h"
#import <CoreLocation/CoreLocation.h>

@protocol geoRegistration

@property (strong, nonatomic) NSMutableArray *callbackGeoArray; //<frank/> indeed

- (void) registerWaitingForGeoFunction:(void (^)(NSString *lng, NSString *lat)) callback;

@end

@interface DSAppDelegate : UIResponder <UIApplicationDelegate, DSLoginViewControllerDelegate, CLLocationManagerDelegate, geoRegistration>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
