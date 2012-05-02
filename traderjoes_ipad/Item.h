#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Item : NSManagedObject
@property (nonatomic, retain) NSNumber* itemID;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSDate* timeStamp;

@end
