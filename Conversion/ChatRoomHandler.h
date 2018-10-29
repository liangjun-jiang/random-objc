//
//  ChatRoomHandler.h
//  Conversion
//
//  Created by l.jiang on 10/28/18.
//  Copyright © 2018 U. of Arizona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatRoomManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatRoomHandler : NSObject<ChatRoomManagerDataSource, ChatRoomManagerDelegate>

@end

NS_ASSUME_NONNULL_END
