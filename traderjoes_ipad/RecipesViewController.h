#import <UIKit/UIKit.h>

@class DetailViewController;
@protocol RKRequestDelegate;

#import <CoreData/CoreData.h>

@interface RecipesViewController : UITableViewController <NSFetchedResultsControllerDelegate, RKRequestDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSArray *categories;

@end
