#import <UIKit/UIKit.h>

@interface StopWatch : NSObject {
 @private
  NSDate *startTime_;
  NSTimeInterval elapsedTime_;
}

@property (nonatomic, readonly) NSTimeInterval elapsedTime;

- (void)start;
- (void)stop;
- (void)reset;

@end
