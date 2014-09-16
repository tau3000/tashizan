#import "Question.h"

@implementation Question

@synthesize identifier = identifier_;
@synthesize num1 = num1_;
@synthesize num2 = num2_;
@synthesize answer = answer_;

- (id)init {
  self = [super init];
  if (!self) return nil;

  // identifier
  CFUUIDRef uuid;
  uuid = CFUUIDCreate(NULL);
  identifier_ = (NSString*)CFUUIDCreateString(NULL, uuid);
  CFRelease(uuid);
  
  return self;
}

- (id)initWithRandomMin:(int)min max:(int)max {
  [self init];
  if (!self) return nil;

  [self setWithRandomMin:min max:max];
  
  return self;
}

- (void)setWithRandomMin:(int)min max:(int)max {
  // num1: 1..(max-1)
  num1_ = 1 + arc4random() % (max - 1);
  num2_ = num1_ > min ? 0 : min - num1_;
  num2_ += 1 + arc4random() % (max - num1_ - num2_);
}

- (BOOL)isCorrect {
  return num1_ + num2_ == answer_ ? YES: NO;
}

- (void)dealloc {
  [identifier_ release], identifier_ = nil;
  [super dealloc];
}

@end
