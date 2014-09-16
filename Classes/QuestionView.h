#import <UIKit/UIKit.h>

@interface QuestionView : UIView {
  NSMutableArray *answerButtons_;
  UIViewController *viewController_;
}

- (id)initWithViewController:(UIViewController *)viewController;
- (void)drawLabelWithText:(NSString *)text x:(float)x y:(float)y width:(float)width;
- (void)drawButtonWithText:(NSString *)text x:(float)x y:(float)y width:(float)width action:(SEL)action;
- (void)drawQuestionLabels;
- (void)drawNumberButtons;
- (void)drawBackground;
- (UIButton *)answerButtonAtIndex:(int)index;

@end
