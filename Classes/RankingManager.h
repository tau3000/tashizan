#import <UIKit/UIKit.h>
#import "Score.h"

@interface RankingManager : NSObject {
  NSMutableArray* scores_;
}

@property (nonatomic, readonly) NSArray* scores;

+ (RankingManager *)sharedManager;

- (Score *)scoreAtIndex:(int)index;
- (void)addScore:(Score *)score;
- (void)removeAllScores;

- (void)load;
- (void)save;

@end
