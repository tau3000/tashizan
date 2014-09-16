#import <UIKit/UIKit.h>
#import "Score.h"

@interface ScoreManager : NSObject {
  NSMutableArray* scores_;
}

@property (nonatomic, readonly) NSArray* scores;

+ (ScoreManager *)sharedManager;

- (Score *)scoreAtIndex:(int)index;
- (void)addScore:(Score *)score;
- (void)removeAllScores;

- (void)load;
- (void)save;

@end
