
@import Parse;
#import "Sample.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message : PFObject <PFSubclassing>

@property (nullable, nonatomic, strong) PFUser *user;
@property (nullable, nonatomic, strong) NSString *userName;
@property (nullable, nonatomic, strong) NSString *agentSays;
@property (nullable, nonatomic, strong) NSString *agentThinks;
@property (nullable, nonatomic, strong) NSString *userSays;
@property (nullable, nonatomic, strong) Sample *videoSample;
@property (nullable, nonatomic, strong) PFObject *room;
@property (nullable, nonatomic, strong) NSString *roomName;

@end

NS_ASSUME_NONNULL_END
