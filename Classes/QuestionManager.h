#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionManager : NSObject {
  NSMutableArray* questions_;
}

@property (nonatomic, readonly) NSArray* questions;

+ (QuestionManager *)sharedManager;

- (Question *)questionAtIndex:(int)index;
- (void)addQuestion:(Question *)question;
- (void)removeAllQuestions;
- (int)nCorrect;

@end
