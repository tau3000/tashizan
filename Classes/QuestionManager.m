#import "QuestionManager.h"

@implementation QuestionManager

@synthesize questions = questions_;

static QuestionManager *sharedInstance_ = nil;

+ (QuestionManager *)sharedManager {
  if (!sharedInstance_) {
    sharedInstance_ = [[QuestionManager alloc] init];
  }

  return sharedInstance_;
}

- (id)init {
  self = [super init];
  if (!self) {
    return nil;
  }
    
  questions_ = [[NSMutableArray array] retain];

  return self;
}

- (Question *)questionAtIndex:(int)index {
  return [questions_ objectAtIndex:index];
}

- (void)addQuestion:(Question *)question {
  if (!question) {
    return;
  }

  [questions_ addObject:question];
}

- (void)removeAllQuestions {
  [questions_ removeAllObjects];
}

- (int)nCorrect {
  int n = 0;
  for (int i = 0; i < [questions_ count]; i++) {
    Question *question = [questions_ objectAtIndex:i];
    if (question.num1 + question.num2 == question.answer) n++;
  }

  return n;
}

- (void)dealloc {
  [questions_ release], questions_ = nil;
  [super dealloc];
}

@end
