#import "Message.h"

@implementation Message

@dynamic user, userName, agentSays, agentThinks, userSays, videoSample,room, roomName, videoIndex;

+ (NSString *)parseClassName {
  return @"Message";
}

@end
