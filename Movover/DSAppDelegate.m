//
//  DSAppDelegate.m
//  Movover
//
//  Created by @leonardfactory on 23/02/13.
//  Copyright (c) 2013 Movover. All rights reserved.
//

#import "DSAppDelegate.h"
#import "DSSidePanelController.h"
#import "DSProfileManager.h"
#import "DSNewDropManager.h"

#import "UIImageView+AFNetworking.h"

@interface DSAppDelegate ()
{
	DSProfileManager *profileManager;
}

@end

@implementation DSAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize locationManager = _locationManager;
@synthesize callbackGeoArray = _callbackGeoArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self buildCustomAppearence];
	// Building views
    assert([self.window.rootViewController isKindOfClass:[DSSidePanelController class]]);
    
    DSSidePanelController *sidePanelController = (DSSidePanelController *)self.window.rootViewController;
    
    NSDictionary *appViewControllers = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [sidePanelController.storyboard instantiateViewControllerWithIdentifier:@"mapNavigationController"], @"map",
										[sidePanelController.storyboard instantiateViewControllerWithIdentifier:@"journalNavigationController"], @"journal",
										nil];
    
    [sidePanelController setViewControllers:appViewControllers whereSelectedIs:@"journal"];
	
	//LoginViewController
	//<frank>
	profileManager = [[DSProfileManager alloc] init];
	[profileManager loadCookies];
	
	//[profileManager logout];
	if(![profileManager isLogged])
	{
		NSLog(@"User is not logged.");
		
		DSLoginViewController *loginViewController = [sidePanelController.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
		[loginViewController setDelegate:self];
		
		[self.window makeKeyAndVisible];
		[self.window.rootViewController presentModalViewController:loginViewController animated:NO];
	}
	
	_locationManager = [[CLLocationManager alloc] init];
	
	_locationManager.delegate = self;
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	_callbackGeoArray = [[NSMutableArray alloc] init];
	
	
	//DSNewDropManager *nd = [[DSNewDropManager alloc] init];
	
	//UIImageView *test =[[UIImageView alloc] init];
	
	//NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://us.123rf.com/400wm/400/400/henner/henner0908/henner090800002/5436652-ritratto-di-un-giovane-capibara.jpg"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	//[test setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
		//[nd captureWithImage:image WithText:@"lolol image works?!!"];
	//} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
		//NSLog(@"shit");
	//}];
	
	//</frank>
	
	
    return YES;
}

- (void) dismissLoginViewController
{
	[profileManager saveCookies];
	[self.window.rootViewController dismissModalViewControllerAnimated:YES];
}

/**
 * Modifica le images per tutte le view di una determinata classe a priori.
 */
- (void)buildCustomAppearence
{
	
	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"titleBarPlain"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *barButtonImage = [[UIImage imageNamed:@"barButtonBg"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 5, 4)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Shabaka" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Shabaka.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Coordinates

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSString *lng = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString *lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
		
		for (void (^ callback)(NSString *lng, NSString *lat) in _callbackGeoArray) {
			callback(lng,lat);
			[_callbackGeoArray removeObjectIdenticalTo:callback];
		}
		
		[_locationManager stopUpdatingLocation];
    }
}


- (void) registerWaitingForGeoFunction:(void (^)(NSString *lng, NSString *lat)) callback
{
	[_locationManager startUpdatingLocation];
	
	[_callbackGeoArray addObject:[callback copy]];
}



@end
