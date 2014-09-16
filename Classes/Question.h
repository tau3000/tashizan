#import <UIKit/UIKit.h>

@interface Question : NSObject {
  NSString *identifier_;
  int num1_;
  int num2_;
  int answer_;
}

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic) int num1;
@property (nonatomic) int num2;
@property (nonatomic) int answer;

- (id)initWithRandomMin:(int)min max:(int)max;
- (void)setWithRandomMin:(int)min max:(int)max;
- (BOOL)isCorrect;

@end
