#import "ExamViewController.h"
#import "ScoreViewController.h"
#import "QuestionManager.h"
#import "ScoreManager.h"
#import "RankingManager.h"

@implementation ExamViewController

- (id)init {
  self = [super init];
  if (!self) return nil;

  currentPos_ = 0;
  questionView_ = [[QuestionView alloc] initWithViewController:self];
  stopWatch_ = [[StopWatch alloc] init];

  QuestionManager *manager = [QuestionManager sharedManager];
  [manager removeAllQuestions];
  for (int i = 0; i < 10; i++) {
    Question *question = [[[Question alloc] initWithRandomMin:10 max:39] autorelease];
    [manager addQuestion:question];
  }

  [stopWatch_ reset];
  [stopWatch_ start];

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [questionView_ drawBackground];
  [questionView_ drawQuestionLabels];
  [questionView_ drawNumberButtons];

  // Up/Down/Quit button
  //[self drawButtonWithText:@" ↑" x:190 y:410 action:@selector(pushUp)];
  //[self drawButtonWithText:@" ↓" x:250 y:410 action:@selector(pushDown)];
  [questionView_ drawButtonWithText:@"クリア" x:10 y:410 width:116 action:@selector(clearAnswers)];
  [questionView_ drawButtonWithText:@"中断" x:130 y:410 width:86 action:@selector(alertAbort)];
  [questionView_ drawButtonWithText:@"採点" x:220 y:410 width:86 action:@selector(alertScore)];

  [self setCurrentPos:0];
}

- (void)alertAbort {
  [stopWatch_ stop];
  abortAlert_ = [UIAlertView alloc];
  [abortAlert_ initWithTitle:@"確認"
                     message:@"中断します。よろしいですか?"
                    delegate:self
           cancelButtonTitle:@"いいえ"
           otherButtonTitles:@"はい", nil];
  [abortAlert_ show];
}

- (void)abort {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertScore {
  [stopWatch_ stop];
  scoreAlert_ = [UIAlertView alloc];
  [scoreAlert_ initWithTitle:@"確認"
                     message:@"採点します。よろしいですか?"
                    delegate:self
           cancelButtonTitle:@"いいえ"
           otherButtonTitles:@"はい", nil];
  [scoreAlert_ show];
}

- (void)score {
  QuestionManager *questionManager = [QuestionManager sharedManager];
  NSArray *questions = questionManager.questions;
  for (int i = 0; i < [questions count]; i++) {
    Question *question = [questions objectAtIndex:i];
    UIButton *button = [questionView_ answerButtonAtIndex:i];
    NSString *title = button.currentTitle;
    int answer = [title intValue];
    question.answer = answer;
  }

  Score *score = [[[Score alloc] init] autorelease];
  score.nCorrect = [questionManager nCorrect];
  score.elapsedTime = stopWatch_.elapsedTime;
  score.date = [NSDate date];

  ScoreManager *scoreManager = [ScoreManager sharedManager];
  [scoreManager addScore:score];
  [scoreManager save];

  RankingManager *rankingManager = [RankingManager sharedManager];
  [rankingManager addScore:score];
  [rankingManager save];

  ScoreViewController *scoreViewController = [[[ScoreViewController alloc] init] autorelease];
  [self.navigationController pushViewController:scoreViewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == alertView.cancelButtonIndex) {
    [stopWatch_ start];
  } else if (alertView == abortAlert_) {
    [self abort];
  } else if (alertView == scoreAlert_) {
    [self score];
  } else {
    NSLog(@"Invalid alertView");
  }

  [alertView release];
}

- (void)setCurrentPos:(int)num {
  UIButton *button = [questionView_ answerButtonAtIndex:currentPos_];
  [button setBackgroundColor:[UIColor whiteColor]];

  currentPos_ = num;
  button = [questionView_ answerButtonAtIndex:currentPos_];
  UIColor *color = [UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1.0];
  [button setBackgroundColor:color];
}

- (void)setCurrentPos0 { [self setCurrentPos:0]; }
- (void)setCurrentPos1 { [self setCurrentPos:1]; }
- (void)setCurrentPos2 { [self setCurrentPos:2]; }
- (void)setCurrentPos3 { [self setCurrentPos:3]; }
- (void)setCurrentPos4 { [self setCurrentPos:4]; }
- (void)setCurrentPos5 { [self setCurrentPos:5]; }
- (void)setCurrentPos6 { [self setCurrentPos:6]; }
- (void)setCurrentPos7 { [self setCurrentPos:7]; }
- (void)setCurrentPos8 { [self setCurrentPos:8]; }
- (void)setCurrentPos9 { [self setCurrentPos:9]; }

- (void)push:(int)num {
  UIButton *button = [questionView_ answerButtonAtIndex:currentPos_];
  NSString *title = button.currentTitle;
  if ([title length] >= 2) return;
  if ([title length] == 0 && num == 0) return;
  NSString *newTitle = [NSString stringWithFormat:@"%@%d", title, num];
  [button setTitle:newTitle forState:UIControlStateNormal];
}

- (void)push1 { [self push:1]; }
- (void)push2 { [self push:2]; }
- (void)push3 { [self push:3]; }
- (void)push4 { [self push:4]; }
- (void)push5 { [self push:5]; }
- (void)push6 { [self push:6]; }
- (void)push7 { [self push:7]; }
- (void)push8 { [self push:8]; }
- (void)push9 { [self push:9]; }
- (void)push0 { [self push:0]; }

- (void)pushUp {
  currentPos_ = (currentPos_ +9) % 10;
}

- (void)pushDown {
  currentPos_ = (currentPos_ + 1) % 10;
}

- (void)clearAnswers {
  UIButton *button = [questionView_ answerButtonAtIndex:currentPos_];
  [button setTitle:@"" forState:UIControlStateNormal];
}

- (void)dealloc {
  [stopWatch_ release], stopWatch_ = nil;
  [questionView_ release], questionView_ = nil;
  [super dealloc];
}

@end
