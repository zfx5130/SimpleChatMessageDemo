//
//  ChatMessageData.h
//  ChatDemo
//
//  Created by dev on 15/12/3.
//  Copyright © 2015年 thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSQMessages.h>

@interface ChatMessageDataModel : NSObject <JSQMessageData>

/*
 * senderId
 */
@property (copy, nonatomic) NSString *senderId;

/*
 * senderDisplayname
 */
@property (copy, nonatomic) NSString *senderDisplayName;

/*
 * sender date
 */
@property (copy, nonatomic) NSDate *date;

/**
 *  judge the message is the text or media
 */
@property (assign, nonatomic) BOOL isMediaMessage;

/*
 * sender text
 */
@property (copy , nonatomic) NSString *text;

/*
 * senderId
 */
@property (copy, nonatomic) id<JSQMessageMediaData> media;

/**
 *  init
 *
 *  @param senderId          sender ID
 *  @param senderDisplayName sender Display name
 *  @param date              send date
 *  @param text              send text
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text;
@end
