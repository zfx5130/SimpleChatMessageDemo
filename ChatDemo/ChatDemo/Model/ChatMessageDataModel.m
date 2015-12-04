//
//  ChatMessageData.m
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import "ChatMessageDataModel.h"

@implementation ChatMessageDataModel


- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text {
    self = [super init];
    if (self) {
        _senderId = senderId;
        _senderDisplayName = senderDisplayName;
        _date = date;
        _text = text;
    }
    return self;
}

- (NSUInteger)messageHash {
    return self.hash;
}

- (NSUInteger)hash {
    NSUInteger contentHash =
    self.isMediaMessage ? [self.media mediaHash] : self.text.hash;
    return self.senderId.hash ^ self.date.hash ^ contentHash;
}

- (NSString *)description {
    NSString *description =
    [NSString stringWithFormat:@"class=%@\n senderId=%@ \n senderDisplayName=%@ \n date=%@\n isMediaMessage=%@\n text=%@\n media=%@\b",
     [self class],
     self.senderId,
     self.senderDisplayName,
     self.date,
     @(self.isMediaMessage),
     self.text,
     self.media];
    return description;
}

@end
