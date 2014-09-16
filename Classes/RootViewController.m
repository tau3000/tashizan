#import "RootViewController.h"
#import "ExamViewController.h"
#import "ScoreHistoryViewController.h"
#import "RankingViewController.h"

@implementation RootViewController

- (void)drawButtonWithText:(NSString *)text x:(float)x y:(float)y width:(float)width height:(float)height action:(SEL)action {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(x, y, width, height);
  button.titleLabel.font = [UIFont systemFontOfSize:24];
  [button setTitle:text forState:UIControlStateNormal];

  [button addTarget:self
             action:action
	  forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.navigationController setNavigationBarHidden:YES animated:YES];
  self.title = @"足し算ドリル";

  // Background image
  UIImage *image = [UIImage imageNamed:@"Default.png"];
  UIImageView *imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
  //imageView.center = self.view.center;
  [imageView setFrame:CGRectMake(0, -20, 320, 480)];
  [imageView setContentMode:UIViewContentModeTop];
  [self.view addSubview:imageView];
  
  // Title
  UILabel *label = [[[UILabel alloc] init] autorelease];
  label.frame = CGRectMake(40, 20, 240, 50);
  label.font = [UIFont boldSystemFontOfSize:28];
  label.textColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:1];
  label.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
  label.textAlignment = NSTextAlignmentCenter;
  label.text = @"足し算ドリル";
  [self.view addSubview:label];

  // Ranking button
  [self drawButtonWithText:@"スタート"
			 x:70
			 y:300
		     width:180
		    height:40
		    action:@selector(start)];

  // Score history button
  [self drawButtonWithText:@"ランキング"
			 x:70
			 y:350
		     width:180
		    height:40
		    action:@selector(ranking)];

  // Start button
  [self drawButtonWithText:@"今までの記録"
			 x:70
			 y:400
		     width:180
		    height:40
		    action:@selector(history)];
}

- (void)start {
  ExamViewController *viewController =
    [[[ExamViewController alloc] init] autorelease];
  [self.navigationController pushViewController:viewController animated:YES];
}

- (void)history {
  ScoreHistoryViewController *viewController =
    [[[ScoreHistoryViewController alloc] init] autorelease];
  [self.navigationController pushViewController:viewController animated:YES];
}

- (void)ranking {
  RankingViewController *viewController =
    [[[RankingViewController alloc] init] autorelease];
  [self.navigationController pushViewController:viewController animated:YES];
}

- (void)dealloc {
  [super dealloc];
}

@end
