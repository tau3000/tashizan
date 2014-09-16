#import "QuestionView.h"
#import "QuestionManager.h"

@implementation QuestionView

- (id)initWithViewController:(UIViewController *)viewController {
  viewController_ = [super init];
  if (!viewController_) return nil;

  viewController_ = viewController;
  answerButtons_ = [[NSMutableArray alloc] init];

  return self;
}

- (void)drawLabelWithText:(NSString *)text x:(float)x y:(float)y width:(float)width {
  UILabel *label = [[[UILabel alloc] init] autorelease];
  label.frame = CGRectMake(x, y, width, 22);
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont systemFontOfSize:24];
  label.backgroundColor = [UIColor clearColor];
  label.text = text;
  [viewController_.view addSubview:label];
}

- (void)drawLabelWithText:(NSString *)text x:(float)x y:(float)y {
  [self drawLabelWithText:text x:x y:y width:40];
}

- (void)drawLabelWithInt:(int)n x:(float)x y:(float)y {
  [self drawLabelWithText:[NSString stringWithFormat:@"%d", n] x:x y:y];
}

- (UIButton *)drawAnswerButtonWithIndex:(int)i x:(float)x y:(float)y {
  //UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  CGRect rect = CGRectMake(x, y, 60, 26);
  UIButton *button = [[[UIButton alloc] initWithFrame:rect] autorelease];
  //[button setFrame:CGRectMake(x, y, 60, 26)];
  //UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  //UIImage *image = [UIImage imageNamed:@"answer.png"];
  //[button setImage:image forState:UIControlStateNormal];

  Question *question = [[QuestionManager sharedManager] questionAtIndex:i];
  NSString *answer;
  if (question.answer == 0) {
    answer = @"";
  } else {
    answer = [NSString stringWithFormat:@"%d", question.answer];
  }

  [button setTitle:answer forState:UIControlStateNormal];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setBackgroundColor:[UIColor whiteColor]];
  UILabel *label = button.titleLabel;
  label.font = [UIFont systemFontOfSize:24];
  label.textAlignment = NSTextAlignmentRight;

  NSString *actionText = [NSString stringWithFormat:@"setCurrentPos%d", i];
  SEL action = NSSelectorFromString(actionText);
  [button addTarget:viewController_
             action:action
   forControlEvents:UIControlEventTouchUpInside];
  [viewController_.view addSubview:button];

  return button;
}

- (void)drawQuestionLabels {
  NSArray *questions = [QuestionManager sharedManager].questions;
  for (int i = 0; i < [questions count]; i++) {
    Question *question = [questions objectAtIndex:i];
    int y = 20 + i * 30;
    [self drawLabelWithInt:question.num1 x:40  y:y];
    [self drawLabelWithInt:question.num2 x:120 y:y];
    [self drawLabelWithText:@"+" x:80 y:y];
    [self drawLabelWithText:@"=" x:165 y:y];
    UIButton *answerButton = [self drawAnswerButtonWithIndex:i x:210 y:y];
    [answerButtons_ addObject:answerButton];
  }
}

- (void)drawButtonWithText:(NSString *)text x:(float)x y:(float)y width:(float)width action:(SEL)action {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(x, y, width, 36);
  button.titleLabel.font = [UIFont systemFontOfSize:28];
  [button setTitle:text forState:UIControlStateNormal];
  [button addTarget:viewController_
             action:action
   forControlEvents:UIControlEventTouchUpInside];
  [viewController_.view addSubview:button];
}

- (void)drawButtonWithText:(NSString *)text x:(float)x y:(float)y action:(SEL)action {
  [self drawButtonWithText:text x:x y:y width:56 action:action];
}

- (void)drawNumberButtons {
  for (int i = 0; i < 10; i++) {
    NSString *text = [NSString stringWithFormat:@"%d", (i + 1) % 10];
    NSString *actionText = [NSString stringWithFormat:@"push%d", (i + 1) % 10];
    SEL action = NSSelectorFromString(actionText);
    float x = 10 + (i % 5) * 60;
    float y = 330 + (int)(i / 5) * 40;
    [self drawButtonWithText:text x:x y:y action:action];
  }
}

- (void)drawBackground {
  UIImage *image = [UIImage imageNamed:@"bg_exam.gif"];
  viewController_.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (UIButton *)answerButtonAtIndex:(int)index {
  return [answerButtons_ objectAtIndex:index];
}

- (void)dealloc {
  [answerButtons_ release], answerButtons_ = nil;
  [super dealloc];
}

@end
