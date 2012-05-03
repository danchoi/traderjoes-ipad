#import "AppDelegate.h"
#import "ProductsViewController.h"
#import "RecipesViewController.h"
#import "DetailViewController.h"

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import "Category.h"
#import "Item.h"

@interface AppDelegate ()
@property (strong, nonatomic) UINavigationController *menu_nc;
@property (strong, nonatomic) ProductsViewController *products_vc;
@property (strong, nonatomic) RecipesViewController *recipes_vc;
@end 

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;

@synthesize menu_nc;
@synthesize products_vc;
@synthesize recipes_vc;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


  
 
  // RESTKIT 

  //RKClient *client = [RKClient clientWithBaseURLString: @"http://localhost:3010"];
  // NSLog(@"I am your RKClient singleton : %@", [RKClient sharedClient]);

  [RKObjectManager objectManagerWithBaseURLString:@"http://localhost:3010"];  

  RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[Item class]];
  [itemMapping mapKeyPath:@"name" toAttribute:@"name"];
  [itemMapping mapKeyPath:@"url" toAttribute:@"url"];
  /*
  [itemMapping mapKeyPath:@"item_id" toAttribute:@"itemID"];
  [itemMapping mapKeyPath:@"category_id" toAttribute:@"categoryID"];
  */

  RKObjectMapping *categoryMapping = [RKObjectMapping mappingForClass:[Category class]];
  [categoryMapping mapKeyPath:@"name" toAttribute:@"name"];
  [categoryMapping mapKeyPath:@"category_id" toAttribute:@"categoryID"];
  [categoryMapping mapKeyPath:@"items" toRelationship:@"items" withMapping:itemMapping];

  [[RKObjectManager sharedManager].mappingProvider setMapping:categoryMapping forKeyPath:@"categories"];


  

  self.products_vc = [[ProductsViewController alloc] init];
  self.recipes_vc = [[RecipesViewController alloc] init];
  self.menu_nc = [[UINavigationController alloc] initWithRootViewController:self.products_vc];

  
  DetailViewController *detail_vc = [[DetailViewController alloc] init];
  UINavigationController *detail_nc = [[UINavigationController alloc] initWithRootViewController:detail_vc];

  // set up graph of objects
  self.products_vc.detailViewController = detail_vc;
  self.recipes_vc.detailViewController = detail_vc;
  
  self.splitViewController = [[UISplitViewController alloc] init];
  self.splitViewController.delegate = detail_vc;
  self.splitViewController.viewControllers = [NSArray arrayWithObjects:self.menu_nc, detail_nc, nil];
  
  self.window.rootViewController = self.splitViewController;
  self.products_vc.managedObjectContext = self.managedObjectContext;

  [self.window makeKeyAndVisible];


  return YES;

}

- (void)segmentChanged:(UISegmentedControl*)sender {
  NSString *sel = [sender titleForSegmentAtIndex:[sender selectedSegmentIndex]];
  if ([sel isEqualToString:@"Recipes"]) {
    NSLog(@"recipes");

  } else {
    NSLog(@"products");
  }
};




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






// RESTKIT
- (void)request:(RKRequest*)req didLoadResponse:(RKResponse*)res {
  if ([req isGET]){
    NSLog(@"retrieved response %@", [res bodyAsString]);
  }
}


- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    NSLog(@"Load collection of Categories: %@", objects);
}





// CORE DATA
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
  if (__managedObjectContext != nil) {
    return __managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    __managedObjectContext = [[NSManagedObjectContext alloc] init];
    [__managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
  if (__managedObjectModel != nil) {
    return __managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"traderjoes_ipad" withExtension:@"momd"];
  __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
  if (__persistentStoreCoordinator != nil) {
    return __persistentStoreCoordinator;
  }
  
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"mackey_ipad1.sqlite"];
  
  NSError *error = nil;
  __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
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
     [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
     
     Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
     
     */
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }  
  
  return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
