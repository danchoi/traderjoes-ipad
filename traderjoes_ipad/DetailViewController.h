#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, 
  UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end
