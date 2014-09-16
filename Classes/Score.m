#import "Score.h"

@implementation Score

@synthesize identifier = identifier_;
@synthesize nCorrect = nCorrect_;
@synthesize elapsedTime = elapsedTime_;
@synthesize date = date_;

- (id)init {
  self = [super init];
  if (!self) return nil;
  
  // identifier
  CFUUIDRef uuid;
  uuid = CFUUIDCreate(NULL);
  identifier_ = (NSString*)CFUUIDCreateString(NULL, uuid);
  CFRelease(uuid);

  return self;
}

- (void)dealloc {
  [identifier_ release], identifier_ = nil;
  [super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder {
  self = [super init];
  if (!self) return nil;

  identifier_ = [[decoder decodeObjectForKey:@"identifier"] retain];
  nCorrect_ = [decoder decodeIntForKey:@"nCorrect"];
  elapsedTime_ = [decoder decodeFloatForKey:@"elapsedTime"];
  date_ = [[decoder decodeObjectForKey:@"date"] retain];

  return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
  [encoder encodeObject:identifier_ forKey:@"identifier"];
  [encoder encodeInt:nCorrect_ forKey:@"nCorrect"];
  [encoder encodeFloat:elapsedTime_ forKey:@"elapsedTime"];
  [encoder encodeObject:date_ forKey:@"date"];
}

- (NSComparisonResult)compare:(Score *)data {
  if (self.nCorrect != data.nCorrect) {
    return self.nCorrect > data.nCorrect ? NSOrderedAscending : NSOrderedDescending;
  }

  if (self.elapsedTime != data.elapsedTime) {
    return self.elapsedTime < data.elapsedTime ? NSOrderedAscending : NSOrderedDescending;
  }

  return [self.date compare:data.date];
}

@end
