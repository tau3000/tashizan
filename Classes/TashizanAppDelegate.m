#import "TashizanAppDelegate.h"
#import "RootViewController.h"

@implementation TashizanAppDelegate

@synthesize window = window_;
@synthesize navigationController = navigationController_;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  CGRect bounds = [[UIScreen mainScreen] bounds];
  window_ = [[UIWindow alloc] initWithFrame:bounds];

  RootViewController *viewController = [[[RootViewController alloc] init] autorelease];
  navigationController_ = [UINavigationController alloc];
  [navigationController_ initWithRootViewController:viewController];
  [navigationController_ setNavigationBarHidden:YES animated:YES];

  [window_ addSubview:navigationController_.view];
  [window_ makeKeyAndVisible];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  [navigationController_ release], navigationController_ = nil;
  [window_ release], window_ = nil;
  [super dealloc];
}

@end
