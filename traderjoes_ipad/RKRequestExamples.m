#import "RKRequestExamples.h"

@implementation RKRequestExamples

- (void)sendRequests {
  // Perform a simple HTTP GET and call me back with the results
    NSLog(@"sendRequest");
  [[RKClient sharedClient] get:@"/" delegate:self];

  // Send a POST to a remote resource. The dictionary will be transparently
  // converted into a URL encoded representation and sent along as the request body
  //NSDictionary* params = [NSDictionary dictionaryWithObject:@"RestKit" forKey:@"Sender"];
  //[[RKClient sharedClient] post:@"/other.json" params:params delegate:self];

  // DELETE a remote resource from the server
  //[[RKClient client] delete:@"/missing_resource.txt" delegate:self];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
  if ([request isGET]) {
    // Handling GET /foo.xml

    if ([response isOK]) {
      // Success! Let's take a look at the data
      NSLog(@"Retrieved XML: %@", [response bodyAsString]);
    }

  } else if ([request isPOST]) {

    // Handling POST /other.json
    if ([response isJSON]) {
      NSLog(@"Got a JSON response back from our POST!");
    }

  } else if ([request isDELETE]) {

    // Handling DELETE /missing_resource.txt
    if ([response isNotFound]) {
      NSLog(@"The resource path '%@' was not found.", [request resourcePath]);
    }
  }
}

@end

