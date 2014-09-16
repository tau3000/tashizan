#import "ScoreHistoryViewController.h"
#import "ScoreManager.h"

@implementation ScoreHistoryViewController

#pragma mark -
#pragma mark Initialization

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [[ScoreManager sharedManager] load];
  [self.navigationController setNavigationBarHidden:NO animated:YES];
  self.title = @"今までの記録";
}

- (void)viewWillDisappear:(BOOL)animated {
  [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[ScoreManager sharedManager].scores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
				  reuseIdentifier:@"UITableViewCell"];
    [cell autorelease];
  }

  Score *score = [[ScoreManager sharedManager] scoreAtIndex:indexPath.row];
  NSString *mes = [NSString stringWithFormat:@"%d問正解 %.1f秒",
			     score.nCorrect, score.elapsedTime];
  cell.textLabel.text = mes;

  NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
  [df setDateFormat:@"yyyy/MM/dd HH:mm"];
  cell.detailTextLabel.text = [df stringFromDate:score.date];

  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  [super dealloc];
}

@end
