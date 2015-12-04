//
//  MessageData.h
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kSenderAvatarId = @"0000000002";
static NSString *const kReceiverAvatarId = @"0000000001";
static NSString *const kSenderAvatarDisplayName = @"thomas one";
static NSString *const kReceiverAvatarDisplayName = @"thomas two";
static NSString *const kSenderTextContent = @"和气和气人的发生的发生发";
static NSString *const kReceiverTextContent = @"昵称v规范啥地方放水电费";
static NSString *const kSenderAvatarImageName = @"demo_avatar_sender";
static NSString *const kReceiverAvatarImageName = @"demo_avatar_receiver";


@class ChatMessageBubbleImageModel;
@interface MessageData : NSObject

/**
 *  all user chat messages
 */
@property (strong, nonatomic, readonly) NSMutableArray *messages;

/**
 *  all user avatars
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *avatars;

/**
 *  all chat users
 */
@property (strong, nonatomic, readonly) NSMutableDictionary *users;

/**
 *  sender bubble image model
 */
@property (strong, nonatomic, readonly) ChatMessageBubbleImageModel *senderBubbleImageModel;

/**
 *  receiver bubble image model
 */
@property (strong, nonatomic, readonly) ChatMessageBubbleImageModel *receiverBubbleImageModel;

@end
