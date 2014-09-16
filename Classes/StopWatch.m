#import "StopWatch.h"

@implementation StopWatch

@synthesize elapsedTime = elapsedTime_;

- (void)start {
  startTime_ = [[NSDate date] retain];
}

- (void)stop {
  elapsedTime_ += -[startTime_ timeIntervalSinceNow];
}

- (void)reset {
  elapsedTime_ = 0.0;
}

- (void)dealloc {
  [startTime_ release], startTime_ = nil;
  [super dealloc];
}

@end
