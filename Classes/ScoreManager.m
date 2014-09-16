#import "ScoreManager.h"

@implementation ScoreManager

@synthesize scores = scores_;

static ScoreManager *sharedInstance_ = nil;

+ (ScoreManager *)sharedManager {
  if (!sharedInstance_) {
    sharedInstance_ = [[ScoreManager alloc] init];
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
  return [scores_ objectAtIndex:([scores_ count] - 1 - index)];
}

- (void)addScore:(Score *)score {
  if (!score) return;

  [scores_ addObject:score];
}

- (void)removeAllScores {
  [scores_ removeAllObjects];
}

- (NSString*)scoreDir {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  if ([paths count] < 1) return nil;

  NSString *path = [paths objectAtIndex:0];
  return [path stringByAppendingPathComponent:@".score"];
}

- (NSString*)scorePath {
  return [[self scoreDir] stringByAppendingPathComponent:@"score.dat"];
}

- (void)load {
  NSString *path = [self scorePath];
  if (!path || ![[NSFileManager defaultManager] fileExistsAtPath:path]) return;
    
  NSArray *scores;
  scores = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
  if (!scores) return;

  [scores_ setArray:scores];
}

- (void)save {
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  NSString *dir = [self scoreDir];
  if (![fileMgr fileExistsAtPath:dir]) {
    NSError *error;
    [fileMgr createDirectoryAtPath:dir 
       withIntermediateDirectories:YES
			attributes:nil
			     error:&error];
  }

  NSString *path = [self scorePath];
  [NSKeyedArchiver archiveRootObject:scores_ toFile:path];
}

@end
