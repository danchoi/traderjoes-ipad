#import <RestKit/RestKit.h>

// Here we declare that we implement the RKRequestDelegate protocol
// Check out RestKit/Network/RKRequest.h for additional delegate methods
// that are available.
@interface RKRequestExamples : NSObject <RKRequestDelegate> 

- (void)sendRequests;

@end


