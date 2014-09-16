#import <UIKit/UIKit.h>

@interface Score : NSObject {
  NSString *identifier_;
  int nCorrect_;
  NSTimeInterval elapsedTime_;
  NSDate *date_;
  //NSString *username;
}

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic) int nCorrect;
@property (nonatomic) NSTimeInterval elapsedTime;
@property (nonatomic, retain) NSDate *date;

@end
