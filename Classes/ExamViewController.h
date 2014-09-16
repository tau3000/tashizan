#import <UIKit/UIKit.h>
#import "StopWatch.h"
#import "QuestionView.h"

@interface ExamViewController : UIViewController {
 @private
  int currentPos_;
  StopWatch *stopWatch_;
  QuestionView *questionView_;
  UIAlertView *abortAlert_;
  UIAlertView *scoreAlert_;
}

- (void)setCurrentPos:(int)num;

@end
