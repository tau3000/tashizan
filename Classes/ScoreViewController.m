#import "ScoreViewController.h"
#import "QuestionManager.h"
#import "ScoreManager.h"
#import "Score.h"

@implementation ScoreViewController

- (id)init {
  self = [super init];
  if (!self) return nil;

  questionView_ = [[QuestionView alloc] initWithViewController:self];
    
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [questionView_ drawBackground];
  [questionView_ drawQuestionLabels];

  NSArray *questions = [QuestionManager sharedManager].questions;
  for (int i = 0; i < [questions count]; i++) {
    Question *question = [questions objectAtIndex:i];
    UIColor *color;
    if (question.isCorrect) {
      color = [UIColor colorWithRed:1.0 green:0.6 blue:0.6 alpha:1.0];
    } else {
      color = [UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:1.0];
    }
    UIButton *button = [questionView_ answerButtonAtIndex:i];
    [button setBackgroundColor:color];
  }

  Score *score = [[ScoreManager sharedManager].scores lastObject];
  NSString *mes = [NSString stringWithFormat:@"%d問正解   時間%.1f秒",
			    score.nCorrect, score.elapsedTime];
  [questionView_ drawLabelWithText:mes x:10 y:350 width:300];
  [questionView_ drawButtonWithText:@"OK" x:120 y:390 width:80 action:@selector(menu)];
}

- (void)menu {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc {
    [super dealloc];
}

@end
