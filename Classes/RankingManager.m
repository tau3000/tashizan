#import "RankingManager.h"

@implementation RankingManager

@synthesize scores = scores_;

static RankingManager *sharedInstance_ = nil;

+ (RankingManager *)sharedManager {
  if (!sharedInstance_) {
    sharedInstance_ = [[RankingManager alloc] init];
  }
  
  return sharedInstance_;
}

- (id)init {
  self = [super init];
  if (!self) {
    return nil;
  }
  
  scores_ = [[NSMutableArray array] retain];
  
  return self;
}

- (void)dealloc {
  [scores_ release], scores_ = nil;
  [super dealloc];
}

- (Score *)scoreAtIndex:(int)index {
  return [scores_ objectAtIndex:index];
}

- (void)addScore:(Score *)score {
  if (!score) return;

  [scores_ addObject:score];
  [scores_ sortUsingSelector:@selector(compare:)];

  if ([scores_ count] > 20) {
    [scores_ removeLastObject];
  }
}

- (void)removeAllScores {
  [scores_ removeAllObjects];
}

- (NSString*)rankingDir {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  if ([paths count] < 1) return nil;
  
  NSString *path = [paths objectAtIndex:0];
  return [path stringByAppendingPathComponent:@".ranking"];
}

- (NSString*)rankingPath {
  return [[self rankingDir] stringByAppendingPathComponent:@"ranking.dat"];
}

- (void)load {
  NSString *path = [self rankingPath];
  if (!path || ![[NSFileManager defaultManager] fileExistsAtPath:path]) return;

  NSArray *scores;
  scores = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
  if (!scores) return;
  
  [scores_ setArray:scores];
}

- (void)save {
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  NSString *dir = [self rankingDir];
  if (![fileMgr fileExistsAtPath:dir]) {
    NSError *error;
    [fileMgr createDirectoryAtPath:dir
       withIntermediateDirectories:YES
			attributes:nil
			     error:&error];
  }
  
  NSString *path = [self rankingPath];
  [NSKeyedArchiver archiveRootObject:scores_ toFile:path];
}

@end
