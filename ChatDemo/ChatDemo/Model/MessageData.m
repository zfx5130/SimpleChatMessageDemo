//
//  MessageData.m
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import "MessageData.h"

#import "ChatAvatarImageModel.h"
#import "ChatMessageBubbleImageModel.h"
#import "ChatMessageDataModel.h"

#import "macro.h"


@interface MessageData ()

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSMutableDictionary *avatars;

@property (strong, nonatomic) NSMutableDictionary *users;

@property (strong, nonatomic) ChatMessageBubbleImageModel *senderBubbleImageModel;

@property (strong, nonatomic) ChatMessageBubbleImageModel *receiverBubbleImageModel;

@end

@implementation MessageData


- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSMutableDictionary *)avatars {
    if (!_avatars) {
        _avatars = [NSMutableDictionary dictionary];
        ChatMessageDataModel *senderImage = (ChatMessageDataModel *)[JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:kSenderAvatarImageName]
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        
        ChatMessageDataModel *receiverImage = (ChatMessageDataModel *)[JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:kReceiverAvatarImageName]
                                                                                      diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        NSDictionary *userAvatars = @{
                                      kSenderAvatarId : senderImage,
                                      kReceiverAvatarId : receiverImage
                                      };
        [_avatars addEntriesFromDictionary:userAvatars];
    }
    return _avatars;
}

- (NSMutableDictionary *)users {
    if (!_users) {
        _users = [NSMutableDictionary dictionary];
        NSDictionary *allUsers = @{
                                   kSenderAvatarId : kSenderAvatarDisplayName,
                                   kReceiverAvatarId : kReceiverAvatarDisplayName
                                   };
        [_users addEntriesFromDictionary:allUsers];
    }
    return _users;
}

- (NSMutableArray *)messages {
    
    if (!_messages) {
        _messages = [NSMutableArray array];
        NSArray *allMessages = @[
                                 [[ChatMessageDataModel alloc] initWithSenderId:kSenderAvatarId
                                                              senderDisplayName:kSenderAvatarDisplayName
                                                                           date:[NSDate distantPast]
                                                                           text:kSenderTextContent],
                                 [[ChatMessageDataModel alloc] initWithSenderId:kReceiverAvatarId
                                                              senderDisplayName:kReceiverAvatarDisplayName
                                                                           date:[NSDate date]
                                                                           text:kReceiverTextContent]
                                 ];
        [_messages addObjectsFromArray:allMessages];
    }
    return _messages;
}

- (ChatMessageBubbleImageModel *)senderBubbleImageModel {
    if (!_senderBubbleImageModel) {
        _senderBubbleImageModel = [[ChatMessageBubbleImageModel alloc] initWithMessageBubbleImage:[UIImage imageNamed:@"bg_image"]
                                                                    messageBubbleHighLightedImage:nil];
    }
    return _senderBubbleImageModel;
}

- (ChatMessageBubbleImageModel *)receiverBubbleImageModel {
    if (!_receiverBubbleImageModel) {
        _receiverBubbleImageModel = [[ChatMessageBubbleImageModel alloc] initWithMessageBubbleImage:[UIImage imageNamed:@"bundle_image"]
                                                                    messageBubbleHighLightedImage:nil];
    }
    return _receiverBubbleImageModel;
}

@end
