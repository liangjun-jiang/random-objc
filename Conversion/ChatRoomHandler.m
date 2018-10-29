//
//  ChatRoomHandler.m
//  Conversion
//
//  Created by l.jiang on 10/28/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import "ChatRoomHandler.h"
@import Parse;
#import "Room.h"
#import "Message.h"
@import ParseLiveQuery;
#import "ChatRoomManager.h"

@interface ChatRoomHandler()
@property (nonatomic, strong) Room *room;
@property (nonatomic, strong) PFLiveQueryClient *client;
@end

@implementation ChatRoomHandler
- (instancetype)initWithRoom:(Room *)room {
    self = [super init];
    if (!self) return self;
    
    self.room = room;
    self.client = [[PFLiveQueryClient alloc] init];
    
    return self;
}

- (PFQuery *)queryForChatRoomManager:(ChatRoomManager *)manager {
    return [[[Message query] whereKey:@"room_name"
                              equalTo:self.room.name]
            orderByAscending:@"createdAt"];
}

- (PFLiveQueryClient *)liveQueryClientForChatRoomManager:(ChatRoomManager *)manager {
    return self.client;
}

- (void)chatRoomManager:(ChatRoomManager *)manager didReceiveMessage:(Message *)message {
    NSString *formatted = [NSString stringWithFormat:@"%@ %@ %@", message.createdAt, message.authorName, message.message];
    printf("%s\n", formatted.UTF8String);
}
@end
