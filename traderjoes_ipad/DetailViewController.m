#import "DetailViewController.h"
#import "Item.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)segmentChanged:(UISegmentedControl*)sender;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize segmentedControl;

@synthesize webView;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
  if (_detailItem != newDetailItem) {
    _detailItem = newDetailItem;
    
    // Update the view.
    [self configureView];
  }

  if (self.masterPopoverController != nil) {
    [self.masterPopoverController dismissPopoverAnimated:YES];
  }    
}

- (void)configureView
{
  // Update the user interface for the detail item.

  if (self.detailItem) {
    Item *i = (Item*)self.detailItem;
    NSString *fullUrl = [NSString stringWithFormat:@"http://m.traderjoes.com/fearless-flyer/%@", i.url];
    NSLog(@"selected %@ -> %@", i, fullUrl);
    //self.detailDescriptionLabel.text = i.name;
    self.title = i.name;
    NSURL *nsurl = [NSURL URLWithString:fullUrl];
    NSLog(@"nsurl: %@", nsurl);
    [self.webView loadRequest:[NSURLRequest requestWithURL:nsurl]];
  }
}

- (void)viewDidLoad
{
  
  [super viewDidLoad];

  // segmented button
  NSArray *segments = [[NSArray alloc] initWithObjects: @"Flyer", @"Recipes", nil];
  self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
  self.segmentedControl.frame = CGRectMake(0, 0, 140, 28);
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
  self.navigationItem.rightBarButtonItem = item;
  self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
  self.segmentedControl.selectedSegmentIndex = 0;
  [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];


  self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
  self.webView.delegate = self;
  [self.view addSubview:self.webView];
  NSString *url = @"http://traderjoes.com/fearless-flyer";
  //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
  NSLog(@"%@", self.webView);
  [self configureView];
}

- (void)segmentChanged:(UISegmentedControl*)sender {
  NSLog(@"seg changed %d", [sender selectedSegmentIndex]);
  // what is the top menu view controller ?
  
  NSLog(@"seg changed %d", [sender selectedSegmentIndex]);
};

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  self.detailDescriptionLabel = nil;
}

- (void)webViewDidFinishLoad:(UIWebView*)wv {
  NSLog(@"webv did finish load");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Detail", @"Detail");
  }
  return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
  barButtonItem.title = NSLocalizedString(@"Master", @"Master");
  [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
  self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
  // Called when the view is shown again in the split view, invalidating the button and popover controller.
  [self.navigationItem setLeftBarButtonItem:nil animated:YES];
  self.masterPopoverController = nil;
}

@end
