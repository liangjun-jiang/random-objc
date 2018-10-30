#import "Message.h"

@implementation Message

@dynamic user, userName, agentSays, agentThinks, userSays, videoSample,room, roomName;

+ (NSString *)parseClassName {
  return @"Message";
}

@end
