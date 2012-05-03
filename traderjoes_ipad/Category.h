#import <Foundation/Foundation.h>
#import "Item.h"

@interface Category : NSObject
@property (nonatomic, retain) NSNumber* categoryID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSArray* items;

@end
